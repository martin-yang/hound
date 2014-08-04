module Statistics
  class TakeProductsClickRates
    def self.execute
      products_sort_and_reverse
    end

    private
    def self.build_date_style(entity)
      {name: entity.name,short: "#{entity.name[0,10]}...",path: entity.path,rates: entity.click_rates}
    end

    def self.take_products_and_click_rates
      Expand::Entity.all.map{|e| build_date_style(e)}.compact
    end

    def self.products_sort_and_reverse
      take_products_and_click_rates.sort_by{|b| b[:rates]}.reverse
    end
  end
end