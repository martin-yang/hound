module Merchant
  def self.table_name_prefix
    'merchant_'
  end

  def self.had_products(username,session_key,page)
    result=Product::SearchProducts.new("a",page,session_key).execute
    {list: BuildOfHadExpandRequest.execute(result.build_list,ExpandRequest.all.map(&:product_id)),page: result.pre_page(page)}
  end
end
