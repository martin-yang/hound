module AboutUser
  class TakeHadExpandProducts
    attr_accessor :user

    def initialize(username)
      self.user = User.find_by(username: username) rescue nil
    end

    def execute(page)
      return {page: {},list: []} unless user
      take_products(page)
    end

    private
    def take_products(page)
      entities = user.expand_entities
  	  page_count = Search::Page.count(entities.size,1)
  	  pages = page_count.times.map{|k| {num: k+1} }
  	  result = entities.page(page).per(20).order("expand_type,place_id desc").map{|e| take_data_style(e)}
  	  {page: {current_page: page,sum: page_count,pages: pages},list: result}
    end

    def take_data_style(entity)
  	  {id: entity.id,name: entity.name,entity: entity.path,new_path: entity.new_path,img_path: entity.img_path,text_path: entity.text_path,click_rates: entity.click_rates}
    end
  end
end