module Product
  class TakePreferredProducts
    attr_accessor :size
    attr_accessor :shop_site
    attr_accessor :method
    attr_accessor :sign
    attr_accessor :session_key
    attr_accessor :timestamp
    attr_accessor :app_key

    def initialize(size,shop_site,session_key)
      self.timestamp = "#{Time.now.to_i}"
      self.size = size
      self.app_key = ApiServer.app_key_default
      self.shop_site = shop_site
      self.session_key = session_key
      self.method = "org.baihuogou.user.preferred.product"
      sign_sort = "#{ApiServer.app_secret_default}shop_site=#{shop_site}&size=#{size}#{ApiServer.app_secret_default}"
      self.sign = Digest::MD5.hexdigest(URI.escape(sign_sort))
    end

    def execute
      ApiServer.rest_go("get",build_url)
    end

    private
    def build_url
      attribute=ApiServer.public_attribute
      "#{ApiServer.url_head}?sign_method=#{attribute[:sign_method]}&v=#{attribute[:version]}&format=#{attribute[:format]}&method=#{method}&timestamp=#{timestamp}&app_key=#{app_key}&sign=#{sign}&session_key=#{session_key}&size=#{size}&shop_site=#{shop_site}"
    end

  end
end