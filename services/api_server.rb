module ApiServer
  def self.url_head
    I18n.t "url_head"
  end

  def self.public_attribute
    {sign_method: "md5",version: "v1.0",format: "json",time: "0"}
  end

  def self.app_key_default
    ""
  end

  def self.app_secret_default
    ""
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
