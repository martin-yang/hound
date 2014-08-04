module Medium
  class Content < ActiveRecord::Base
  	attr_accessible :resource, :name, :value, :created_at, :updated_at
  	belongs_to :resource, class_name: "Medium::Resource"
  end
end