class CreateMediumExpand
  def self.execute(form_id,medium_attribute,username)
    user = User.find_or_create_by(username: username) rescue nil
    return Prompt.error_500.to_json unless user
  	return Prompt.error_500 unless attribute_empty?(medium_attribute)
  	main=CustomField::Main.find(form_id) rescue nil
  	return Prompt.error_500 unless main
  	Medium::Resource.create_of_form_content(main,medium_attribute,user)
  	main
  end

  private
  def self.attribute_empty?(medium_attribute)
  	result=medium_attribute.map{|k,v| if v.empty? then false else true end} rescue [false]
  	return false if result.include?(false)
  	true
  end
end