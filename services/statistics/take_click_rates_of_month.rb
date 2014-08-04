module Statistics
  class TakeClickRatesOfMonth
  	attr_accessor :year
  	attr_accessor :month
  	attr_accessor :days

  	def initialize(date)
      self.year = date.year
      self.month = date.month
      self.days = Time.days_in_month(month)
  	end

    def execute(username)
      entities = take_entities(username)

      days.times.map{|k|
        {day: "#{year.to_s}-#{month.to_s}-#{(k+1).to_s}",rates: take_click_dates(entities,k)}
      }
    end

    private
    def take_click_dates(entities,day)
      Expand::ClickDate.where(year: year,month: month,day: day+1,entity_id: entities.map(&:id)).inject(0){|sum,c| sum+c.click_rates.size} rescue 0
    end

    def take_entities(username)
      user = User.find_by(username: username) rescue nil
      return [] unless user
      entities = Expand::Entity.where(resource_id: user.resources.map(&:id))
    end
  end
end