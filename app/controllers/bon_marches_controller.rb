require RAILS_ROOT + '/lib/shopzilla/top_tools'
require RAILS_ROOT + '/lib/shopzilla/query_shopzilla'

class BonMarchesController < ApplicationController
  def index
    top_tool = TopTool.new
    @top20brands = top_tool.top20brands()
    @top20favorites = top_tool.top20favorites()
    @top20interests = top_tool.top20interests()

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @top20brands }
    end
  end

  def search
    # Read my utility library for details, it takes both parameters as
    #  1. string
    #  2. Array
    @brands = params[:brands]
    #@brands = ["Nike", "Reebok"]
    @favorites = params[:favorites]
    @interests = params[:interests]

    #Escapinng  '\' character which is a separator used by SOQL
    @brands.sub!("'","\\\\'")
    @favorites.sub!("'","\\\\'")
    @interests.sub!("'","\\\\'")

    query_tool = QueryShopzilla.new
    #@search_results = query_tool.query_strings(@brands, @favorites, @interests)
    @search_results = query_tool.query_arrays(@brands, @favorites, @interests)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @search_results }
    end
    #render :text => 'Search function called.'
  end

end
