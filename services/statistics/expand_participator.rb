module Statistics
  class ExpandParticipator
  	attr_accessor :page
  	attr_accessor :per

  	def initialize(page)
      self.page = page
      self.per = 20
  	end

    def execute
      users=query_all
      page_count=take_page_count(users.size,1)
      result=users.page(page).per(per).map{|user| build_user_expand(user)}.sort_by{|u| u[:rates]}.reverse
      {page: {current_page: page,sum: page_count,pages: take_pages(page_count)},list: result}
    end

    private
    def build_user_expand(user)
      resources = user.resources
      entities = Expand::Entity.where(resource_id: resources.map(&:id))
      take_data_style(user,resources,entities)
    end

    def take_data_style(user,resources,entities)
      {name: user.username,resources: resources.size,products: entities.size,rates: entities.inject(0){|sum,e| sum+e.click_rates}}
    end

    def query_all
      User.all.order("created_at desc")
    end

    def take_page_count(count,num)
      return take_page_count((count-per),num+1) if count > per
      num
    end

    def take_pages(page_count)
      page_count.times.map{|k| {num: k+1}}
    end
  end
end