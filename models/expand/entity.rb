module Expand
  class Entity < ActiveRecord::Base
  	attr_accessible :key, :expand_type, :path, :new_path, :text_path, :img_path, :expand_request_id, :expand_request, :place, :place_id, :brand, :resource, :resource_id, :created_at, :updated_at
  	belongs_to :place, class_name: "Expand::Place"
  	belongs_to :brand, class_name: "Expand::Brand"
  	belongs_to :resource, class_name: "Medium::Resource"
    belongs_to :expand_request, class_name: "Merchant::ExpandRequest"
  	has_many :click_dates, class_name: "Expand::ClickDate"

    def name
      (self.expand_request.name rescue self.expand_type)
    end

  	def up_click_rate
      Expand::ClickDate.create_rate(Time.now,self)
  	end

  	def click_rates
      click_dates.inject(0){|num,c| num + c.click_rates.size} rescue 0
  	end

    def last_date
      click_dates.order("created_at desc").first.click_rates.last.created_at.strftime('%Y-%m-%d %H:%M:%S').to_s rescue ""
    end

  	def self.key(num=nil)
  	  return Digest::SHA1.hexdigest("product_#{num}") if num
      Digest::SHA1.hexdigest("product_#{self.all.size+1}")
    end

    def self.create_of(attribute,expand_request)
      self.create!(BuildExpandAttribute.execute(attribute,expand_request))
    end
  end
end