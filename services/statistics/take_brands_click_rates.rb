module Statistics
  class TakeBrandsClickRates
    def self.execute
      brands_sort_and_reverse
    end

    private
    def self.build_data_style(brand)
      return nil unless brand.name
      {name: brand.name,products: brand.entities.size,rates: brand.entities_of_rates}
    end

    def self.take_brands_and_click_rates
      Expand::Brand.all.map{|b| build_data_style(b)}.compact
    end

    def self.brands_sort_and_reverse
      take_brands_and_click_rates.sort_by{|b| b[:rates]}.reverse
    end
  end
end