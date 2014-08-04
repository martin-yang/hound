module Merchant
  class ExpandRequest < ActiveRecord::Base
    attr_accessible :user, :product_id, :name, :img, :brand_name, :list_price, :default_price, :commission, :created_at, :updated_at
    belongs_to :user, class_name: "User"
    has_many :entities, class_name: "Expand::Entity"

    def expand(attribute)
      Expand::Entity.create_of(attribute,self)
    end
  end
end