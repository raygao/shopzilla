
class TopTool 
  def top20brands
    result = OpenHash.new({})
    sql = "select count(id), Brand__c from Favorite_Brand__c group by Brand__c order by count(id) desc limit 20"
    result = Salesforce::SfBase.query_by_sql(sql)
    return result
  end

  def top20favorites
    result = OpenHash.new({})
    sql = "select count(id), Store_Name__c from Favorite_Store__c group by Store_Name__c order by count(id) desc limit 20"
    result = Salesforce::SfBase.query_by_sql(sql)
    return result
  end

  def top20interests
    result = OpenHash.new({})
    sql = "select count(id), Category_Label__c from Category_Interest__c group by Category_Label__c order by count(id) desc limit 20"
    result = Salesforce::SfBase.query_by_sql(sql)
    return result
  end


end