
class QueryShopzilla
  # Take an string for each, brands, favorites, interests, etc.
  def query_strings(brands = """", favorites = "", interests = "")
    result = OpenHash.new({})
    sql = <<-HERE
      SELECT id,FirstName, LastName, PersonMailingState, Gender__c, PersonMailingPostalCode,
        (SELECT id, Brand__c from Favorite_Brands__r WHERE Brand__c IN('%s')),
        (SELECT id, Store_Name__c from Favorite_Stores__r WHERE Store_Name__c IN('%s')),
        (SELECT id, Category_Label__c from Category_Interests__r WHERE Category_Label__c IN('%s'))
      FROM Account
      WHERE PersonMailingState != NULL
      AND Gender__c in ('Male', 'male', 'Female', 'female')
      AND Stores_Rated_Count__c >= 2
      AND Brand_Favorites_Count__c >= 2
      AND Category_Interest_Count__c > 2
    HERE
    result = Salesforce::SfBase.query_by_sql(sql % [brands, favorites, interests] )
    return result
  end

  # Take an array for each, brands, favorites, interests, etc.
  def query_arrays(brands_array=[], favorites_array=[], interests_array=[])
    result = OpenHash.new({})
    sql = <<-HERE
      SELECT id,FirstName, LastName, PersonMailingState, Gender__c, PersonMailingPostalCode,
        (SELECT id, Brand__c from Favorite_Brands__r WHERE Brand__c IN(%s)),
        (SELECT id, Store_Name__c from Favorite_Stores__r WHERE Store_Name__c IN(%s)),
        (SELECT id, Category_Label__c from Category_Interests__r WHERE Category_Label__c IN(%s))
      FROM Account
      WHERE PersonMailingState != NULL
      AND Gender__c in ('Male', 'male', 'Female', 'female')
      AND Stores_Rated_Count__c >= 2
      AND Brand_Favorites_Count__c >= 2
      AND Category_Interest_Count__c > 2
    HERE

    brands ="''"
    favorites ="''"
    interests = "''"

    if brands_array.empty? && favorites_array.empty? && interests_array.empty?
      # all three are empty
      result = Salesforce::SfBase.query_by_sql(sql % [brands, favorites, interests] )
    else
      brands_array.each do |brand|
        brands <<  ", " + "'" + brand + "'"
      end
      favorites_array.each do |favorite|
        favorites <<  ", " + "'" + favorite + "'"
      end
      interests_array.each do |interest|
        interests <<  ", " + "'" + interest + "'"
      end
      result = Salesforce::SfBase.query_by_sql(sql % [brands, favorites, interests] )
    end
    return result
  end
end