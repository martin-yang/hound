module ApiServer
  def self.url_head
    I18n.t "baihuogou"
  end

  def self.public_attribute
    {sign_method: "md5",version: "v1.0",format: "json",time: "0"}
  end

  def self.app_key_default
    "5a4d4651f0f7fe32bd78e670a1f99539"
  end

  def self.app_secret_default
    "ef6e8a8feb069f3e3d7f7097f0153ac7"
  end

  def self.rest_go(method,url,attribute={})
      self.send(method,url,attribute)
  end

  private
  def self.get(url,attribute)
    JSON.parse(RestClient.get(url))
  end

  def self.post(url,attribute)
    JSON.parse(RestClient.post(url,attribute))
  end
end