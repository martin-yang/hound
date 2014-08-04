module CustomField
  class Form < ActiveRecord::Base
  	attr_accessible :main, :created_at, :updated_at
  	belongs_to :main, class_name: "CustomField::Main"
  	has_many :fields, class_name: "CustomField::Field"

  	def table_head
      fields.map(&:name)
    end

    def fields_to_html
      fields.map{|field| {name: field.name,fields: field.to_html}}.compact
    end
  end
end