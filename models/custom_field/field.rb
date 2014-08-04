module CustomField
  class Field < ActiveRecord::Base
    attr_accessible :name, :category, :form, :created_at, :updated_at
    belongs_to :form, class_name: "CustomField::Form"
    has_one :default_value, class_name: "CustomField::DefaultValue"

    def to_html
      CustomField::DocumentDefine.new(name,default_value).send(category) rescue nil
    end

    def add_default_value(key)
      CustomField::DefaultValue.create!(field: self, value: key)
    end
  end

  class DefaultValue < ActiveRecord::Base
    attr_accessible :field
    belongs_to :field,class_name: "CustomField::Field"
    attr_accessible :value
  end

  class DocumentDefine
    attr_accessor :name
    attr_accessor :default_value

    def initialize(name,default_value)
      self.name=name
      self.default_value=default_value
    end

    def text
      %Q(<input name="#{name}" class="form-control"  type="text" value="#{default_value.value.first rescue nil}" placeholder="必填项" required="required"/>)
    end

    def textarea
      %Q(<textarea name="#{name}" class="form-control"  rows="4" cols="50" placeholder="必填项" required="required">#{default_value.value.join(",") rescue nil}</textarea>)
    end

    def select
      options=default_value.value.map{|key| %Q(<option value="#{key}">#{key}</option>)}.join("") rescue ""
      %Q(<select class="form-control" name="#{name}">#{options}</select>)
    end

    def radio
      return "" unless default_value
      default_value.value.map{|key|
        %Q(<input class="form-control" type="radio" name="#{name}" value="#{key}"/><span>#{key}</span>)
      }.join("")
    end
end

end