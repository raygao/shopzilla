require RAILS_ROOT + '/lib/shopzilla/top_tools'
require RAILS_ROOT + '/lib/shopzilla/query_shopzilla'

class BonMarchesController < ApplicationController
  def index
    # use memcache
    top_tool = TopTool.new
    if Rails.cache.exist? 'top20brands'
      @top20brands = Rails.cache.fetch('top20brands')
    else
      @top20brands = top_tool.top20brands()
      Rails.cache.write('top20brands', @top20brands)
    end

    if Rails.cache.exist? 'top20favorites'
      @top20favorites = Rails.cache.fetch('top20favorites')
    else
      @top20favorites = top_tool.top20favorites()
      Rails.cache.write('top20favorites', @top20favorites)
    end

    if Rails.cache.exist? 'top20interests'
      @top20interests = Rails.cache.fetch('top20interests')
    else
      @top20interests = top_tool.top20interests()
      Rails.cache.write('top20interests', @top20interests)
    end  

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @top20brands }
    end
  end

  def search
    # Read my utility library for details, it takes both parameters as
    #  1. string -->  query_tool.query_strings(@brands, @favorites, @interests)
    #  2. Array --> query_tool.query_arrays(@brands, @favorites, @interests)
    begin

    @brands = params[:brands]
    @favorites = params[:favorites]
    @interests = params[:interests]
    

    # In case the user selected nothing from the list.
    if @brands.nil?
      @brands =['']
    end
    if @favorites.nil?
      @favorites =['']
    end
    if @interests.nil?
      @interests =['']
    end


    # Escaping  '\' character which is a separator used by SOQL
    @brands.each do |brand|
      brand.sub!("'","\\\\'")
    end
    @favorites.each do |favorite|
      favorite.sub!("'","\\\\'")
    end
    @interests.each do |interest|
      interest.sub!("'","\\\\'")
    end

    # Query against Salesforce
    query_tool = QueryShopzilla.new
    #@search_results = query_tool.query_strings(@brands, @favorites, @interests)
    @search_results = query_tool.query_arrays(@brands, @favorites, @interests)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @search_results }
    end
    rescue Exception => e
      flash[:notice] = e.message
      redirect_to :action => "error"
    end

  end

end
