module Expand
  class Place < ActiveRecord::Base
  	attr_accessible :name, :resource, :resource_id, :created_at, :updated_at
    belongs_to :resource, class_name: "Medium::Resource"
  	has_many :entities, class_name: "Expand::Entity"

    def click_rates
      self.entities.inject(0){|sum,e| sum+e.click_rates}
    end

    def last_click_date
      self.entities.map(&:last_date).sort.last
    end
  end
end