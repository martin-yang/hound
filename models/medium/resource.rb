module Medium
  class Resource < ActiveRecord::Base
    attr_accessible :main, :user, :created_at, :updated_at
    belongs_to :main, class_name: "CustomField::Main"
    belongs_to :user, class_name: "User"
    has_many :contents, class_name: "Medium::Content"
    has_many :entities, class_name: "Expand::Entity"
    has_many :places, class_name: "Expand::Place"

    def self.create_of_form_content(main,contents,user=nil)
      resource = self.create(main: main, user: user)
      resource.insert_value_to_content(contents)
    end

    def insert_value_to_content(values)
      values.each do |k,v|
      	Medium::Content.create!(name: k, value: v, resource: self)
      end
      self
    end

    def of_fields
      results={}
      self.contents.order("created_at").each do |content|
        results.store(content.name,content.value)
      end
      results
    end

    def self.all_of_desc(username)
      user=User.find_by(username: username) rescue nil
      return [] unless user
      user.resources.map{|rs|
        {id: rs.id,desc: (rs.contents.find_by_name(rs.main.view_key).value rescue "")}
      }
    end
  end
end