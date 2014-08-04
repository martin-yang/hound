module Search
  class TakeExpandRequestProducts
    attr_accessor :name
    attr_accessor :page
    attr_accessor :per

    def initialize(name,page)
      self.name = name
      self.page = page
      self.per = 20
    end

    def execute
      result=query_all
      page_count=take_page_count(result.size,1)
      {page: {current_page: page,sum: page_count,pages: take_pages(page_count)},list: result.page(page).per(per)}
    end

    private
    def query_all
      return Merchant::ExpandRequest.all if name.empty?
      Merchant::ExpandRequest.where("name like '%#{name}%'")
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