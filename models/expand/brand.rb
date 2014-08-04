module Expand
  class Brand < ActiveRecord::Base
  	attr_accessible :name, :created_at, :updated_at
  	has_many :entities, class_name: "Expand::Entity"

  	def entities_of_rates
      self.entities.inject(0){|sum,e| sum+e.click_rates}
    end
  end
end