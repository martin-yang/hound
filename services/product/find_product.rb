module Product
  class FindProduct
    attr_accessor :product_id
    attr_accessor :method
    attr_accessor :sign
    attr_accessor :session_key
    attr_accessor :timestamp
    attr_accessor :app_key

    def initialize(product_id,session_key)
      self.timestamp = "#{Time.now.to_i}"
      self.app_key = ApiServer.app_key_default
      self.product_id = product_id
      self.session_key = session_key
      self.method = "org.baihuogou.product.item.get"
      sign_sort = "#{ApiServer.app_secret_default}product_id=#{product_id}#{ApiServer.app_secret_default}"
      self.sign = Digest::MD5.hexdigest(URI.escape(sign_sort))
    end

    def execute
      result=ApiServer.rest_go("get",build_url)
      def result.add_expand_request(attributes,username)
        expand_request = Merchant::ExpandRequest.new(build_attributes(attributes,username))
        expand_request.save
        expand_request
      end

      def result.build_attributes(key,username)
        key["user"] = User.find_or_create_by(username: username,role: "merchant")
        key["product_id"] = self["product"]["product_id"]
        key["name"] = self["product"]["product_name"]
        key["brand_name"] = self["product"]["brand_name"]
        key["list_price"] = self["product"]["product_price"]["listPrice"]
        key["default_price"] = self["product"]["product_price"]["defaultPrice"]
        key["img"] = (I18n.t 'image',image_path: self["product"]["large_image_url"])
        key
      end
      result
    end

    private
    def build_url
      attribute=ApiServer.public_attribute
      "#{ApiServer.url_head}?sign_method=#{attribute[:sign_method]}&v=#{attribute[:version]}&format=#{attribute[:format]}&method=#{method}&timestamp=#{timestamp}&app_key=#{app_key}&sign=#{sign}&session_key=#{session_key}&product_id=#{product_id}"
    end
  end
end