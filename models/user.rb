class User < ActiveRecord::Base
  attr_accessible :username, :role, :created_at, :updated_at
  has_many :resources, class_name: "Medium::Resource"
  has_many :expand_requests, class_name: "Merchant::ExpandRequest"

  def self.login(username,pwd)
  	result=::Login::Engine.new(username,pwd).validate
  	return nil if result.eql?(false)
  	result
  end

  def expand_entities
  	Expand::Entity.where(resource_id: self.resources.map(&:id))
  end
end