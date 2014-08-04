class GenerateExpandLink
  def self.execute(link,user)
    return Prompt.error_500 unless link.include?("100hg")
    return Prompt.error_500 if Expand::Entity.where(path: link, resource: user.resources.first).size > 0
    create_of(link,user)
  end

  private
  def self.create_of(link,user)
    resource=user.resources.first
    place=Expand::Place.find_or_create_by(name: (I18n.t "expand.type.link"),resource: resource)
    Expand::Entity.create!(build_create_attribute(link,resource,place))
  end

  def self.build_create_attribute(link,resource,place)
  	key=Expand::Entity.key
  	{path: link,
      key: key,
  	  expand_type: (I18n.t "expand.type.link"),
      brand: Expand::Brand.find_or_create_by(name: (I18n.t "expand.type.link")),
      new_path: (I18n.t "redirect",key: key),
      resource: resource,
      place: place}
  end
end