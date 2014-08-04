module Statistics
  class TakePlacesExpandInfo
    attr_accessor :user
    attr_accessor :custom_main

    def initialize(username,main_id)
      self.user = User.find_by(username: username) rescue nil
      self.custom_main = CustomField::Main.find(main_id) rescue nil
    end

    def execute
      return [] if user.nil? || custom_main.nil?
      take_places_of_main
    end

    private
    def take_places_of_main
      places = []
      user.resources.where(main: custom_main).map(&:places).each do |place_list|
        place_list.each do |pl|
          places << pl
        end 
      end
      places.compact.uniq.sort_by{|p| p.name}.map{|p| take_data_style(p) }
    end

    def take_data_style(place)
      {name: place.name,click_rates: place.click_rates,last_date: place.last_click_date}
    end
  end
end