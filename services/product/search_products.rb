module Product
  class SearchProducts
  	attr_accessor :key
    attr_accessor :page
    attr_accessor :page_size
    attr_accessor :search_type
    attr_accessor :method
    attr_accessor :sign
    attr_accessor :session_key
    attr_accessor :timestamp

    def initialize(key,page,session_key)
      self.timestamp = "#{Time.now.to_i}"
      self.key = key
      self.page = page
      self.page_size = 20
      self.search_type = 1
      self.session_key = session_key
      self.method = "org.baihuogou.product.bhg.search"
      sign_sort = "#{ApiServer.app_secret_default}key=#{key}&page=#{page}&page_size=#{page_size}&search_type=#{search_type}#{ApiServer.app_secret_default}"
      self.sign = Digest::MD5.hexdigest(URI.escape(sign_sort))
    end

    def execute
      result=ApiServer.rest_go("post",build_url,search_attribute)
      def result.pre_page(current_page)
        Search::Page.pre_page(current_page,self)
      end

      def result.build_list
        return [] if self["list"].nil?
        self["list"].map{|rs|
          {id: rs["product_id"],name: build_name(rs["product_name"]),list_price: rs["product_price"]["list_price"],
            default_price: rs["product_price"]["default_price"],
          image: rs["large_image_url"]}
        }
      end

      def result.build_name(names)
        names.map{|n| n["simple_name"]}.compact.join("\n")
      end

      result
    end

    private
    def build_url
      attribute=ApiServer.public_attribute
      "#{ApiServer.url_head}?sign_method=#{attribute[:sign_method]}&v=#{attribute[:version]}&format=#{attribute[:format]}&method=#{method}&timestamp=#{timestamp}&app_key=#{ApiServer.app_key_default}&sign=#{sign}&session_key=#{session_key}"
    end

    def search_attribute
      {key: key,page: page,page_size: page_size,search_type: search_type}
    end
  end
end