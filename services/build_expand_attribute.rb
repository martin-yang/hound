class BuildExpandAttribute
  def self.execute(attribute,expand_request)
    attribute["expand_request"] = expand_request
    attribute["key"] = Expand::Entity.key
    attribute["brand"] = Expand::Brand.find_or_create_by(name: expand_request.brand_name)
    attribute["path"] = BuildExpandAttribute.of_locality_path(expand_request.product_id)
    attribute["new_path"] = BuildExpandAttribute.of_new_path(attribute["key"])
    attribute["text_path"] = BuildExpandAttribute.of_text_path(attribute["new_path"],expand_request.name)
    attribute["img_path"] = BuildExpandAttribute.of_img_path(attribute["new_path"],expand_request.img,expand_request.name)
    attribute
  end

  def self.of_locality_path(logo)
    I18n.t "product", id: logo
  end

  def self.of_new_path(key)
    I18n.t "redirect", key: key
  end

  def self.of_text_path(path,content)
  	%Q(<a href="#{path}" target="_blank">#{content}</a>)
  end

  def self.of_img_path(path,img_path,content)
  	%Q(<a href="#{path}" target="_blank"><img src="#{I18n.t 'image',image_path: img_path}"/><div>#{content}</div></a>)
  end
end