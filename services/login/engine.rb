load File.join(File.dirname(__FILE__), '../', 'api_server.rb')
module Login
  class Engine
    attr_accessor :username
    attr_accessor :pwd
    def initialize(username,pwd)
      self.username = username
      self.pwd = pwd
    end
  
    def validate
      key=take_key
      return false unless key["message"].eql?("SUCCESS")
      login_result=login(key["uuid"])
      return false unless login_result["message"].eql?("SUCCESS")
      {user: username, key: key["uuid"]}
    end

    def take_key
  	  Login::SessionKey.new.go
    end

    def login(session_key)
  	  Login::LoginApply.new(session_key,username,pwd).go
    end
  end

  class SessionKey
    attr_accessor :uuid
    attr_accessor :sign
    attr_accessor :app_key
    attr_accessor :timestamp
    attr_accessor :method

    def initialize
      self.uuid = SecureRandom.uuid
      self.method = "org.baihuogou.user.session"
      self.timestamp = "#{Time.now.to_i}"
      md5_timestamp = Digest::MD5.hexdigest(self.timestamp)
      self.sign = Digest::MD5.hexdigest("#{ApiServer.app_secret_default}time=0&uuid=#{self.uuid}#{ApiServer.app_secret_default}")
      self.app_key = ApiServer.app_key_default
    end

    def go
      attribute=ApiServer.public_attribute
      url="#{ApiServer.url_head}?sign_method=#{attribute[:sign_method]}&v=#{attribute[:version]}&format=#{attribute[:format]}&time=#{attribute[:time]}&uuid=#{uuid}&method=#{method}&timestamp=#{timestamp}&app_key=#{app_key}&sign=#{sign}"
      ApiServer.rest_go("get",url)
    end

    def self.test_i18n
      I18n.t "baihuogou"
    end
  end

  class LoginApply
  	attr_accessor :sign
    attr_accessor :app_key
    attr_accessor :timestamp
    attr_accessor :session_key
    attr_accessor :username
    attr_accessor :pwd
    attr_accessor :method

    def initialize(session_key,username,pwd)
      self.method = "org.baihuogou.user.login"
      self.timestamp = "#{Time.now.to_i}"
      value = URI.escape("#{ApiServer.app_secret_default}pwd=#{pwd}&user_name=#{username}#{ApiServer.app_secret_default}","@")
      self.sign = Digest::MD5.hexdigest(value)
      self.app_key = ApiServer.app_key_default
      self.session_key = session_key
      self.username = URI.escape(username,"@")
      self.pwd = URI.escape(pwd,"@")
    end

    def go
      attribute=ApiServer.public_attribute
      url="#{ApiServer.url_head}?sign_method=#{attribute[:sign_method]}&v=#{attribute[:version]}&format=#{attribute[:format]}&method=#{method}&timestamp=#{timestamp}&app_key=#{app_key}&sign=#{sign}&session_key=#{session_key}"
      ApiServer.rest_go("post",url,{user_name: username,pwd: pwd})
    end
  end

end