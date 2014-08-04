module CustomField
  class Main < ActiveRecord::Base
    attr_accessible :name, :view_key, :created_at, :updated_at
    has_one :form, class_name: "CustomField::Form"
    has_many :resources, class_name: "Medium::Resource"

    def resources_of_form(username)
      user=User.find_by(username: username) rescue nil
      return [] unless user
      user.resources.where(main: self).map{|r| r.of_fields}
    end

    def table_content(username)
      result,head = [],form.table_head
      result << head
      build_result(resources_of_form(username),result,head)
    end

    private
    def build_result(key,result,head)
      key.each do |k|
        result << build_head(head,k)
      end
      result
    end

    def build_head(key,form)
    	rs = []
      key.each do |h|
        rs << form[h]
      end
      rs
    end
  end
end