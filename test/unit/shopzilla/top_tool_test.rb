require 'test_helper'
require RAILS_ROOT + '/lib/shopzilla/top_tools'

class TopToolTest < ActiveSupport::TestCase
  def test_should_return_top_brands
    top_tool = TopTool.new
    results = top_tool.top20brands()
    assert !results.empty?
    p "top20 brands: " + results.size.to_s
  end

  def test_should_return_top_favorites
    top_tool = TopTool.new
    results = top_tool.top20favorites()
    assert !results.empty?
    p "top20 favorites: " + results.size.to_s
  end

  def test_should_return_top_interests
    top_tool = TopTool.new
    results = top_tool.top20interests()
    assert !results.empty?
    p "top20 interests: " + results.size.to_s
  end
end
