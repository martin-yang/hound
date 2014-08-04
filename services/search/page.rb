module Search
  class Page
    def self.pre_page(current_page,data)
      sum=pages(data["num"],1)
      {pages: sum.times.map{|k| {num:k+1}},current_page: (current_page.to_i rescue 1),sum: sum}
    end

    def self.pages(count,num)
      return pages((count-20),num+1) if count > 20
      num
    end

    def self.count(key,num)
      return count((key-20),num+1) if key > 20
      num
    end
  end
end