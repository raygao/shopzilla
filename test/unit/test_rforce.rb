require 'test_helper'
require RAILS_ROOT + '/lib/shopzilla/top_tools'

class TopToolTest < ActiveSupport::TestCase
  def test_should_return_top_brands
    limit = 800
    sql = <<-HERE
      SELECT id, Name from Account Limit %d
    HERE
    results = Salesforce::SfBase.query_by_sql(sql %[800])
    #assert !results.empty?
    assert ((results.size == limit) && !results.empty?)
  end
end
