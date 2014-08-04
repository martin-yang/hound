module Merchant
  class BuildOfHadExpandRequest
    def self.execute(products,expand_request_ids)
      result = []
      products.each do |product|
        if expand_request_ids.include?(product[:id])
          product.store("had_expand_request","1")
        end
        result << product
      end
      result
    end
  end
end