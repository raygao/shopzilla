require 'test_helper'
require RAILS_ROOT + '/lib/shopzilla/query_shopzilla'

class TopToolTest < ActiveSupport::TestCase
  def test_accounts_with_string_parameters
    query_tool = QueryShopzilla.new
    results = query_tool.query_strings('Sony', 'Walmart.com', 'Home')
    assert !results.empty?
    p "Query with string parameters -> size: " + results.size.to_s
  end

  def test_accounts_without_string_parameters
    query_tool = QueryShopzilla.new
    results = query_tool.query_strings()
    assert !results.empty?
    p "Query without restrictions -> size: " + results.size.to_s
  end

  def test_accounts_with_arrays_as_parameters
    query_tool = QueryShopzilla.new
    results = query_tool.query_arrays(['Sony'], ['Walmart.com'], ['Home'])
    assert !results.empty?
    p "Query with array as parameters -> size: " + results.size.to_s
  end

  def test_accounts_with_empty_arrays_as_parameters
    query_tool = QueryShopzilla.new
    results = query_tool.query_arrays([],[],[])
    assert !results.empty?
    p "Query with array as parameters -> size: " + results.size.to_s
  end

end
