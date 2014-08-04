module Expand
  class ClickDate < ActiveRecord::Base
    attr_accessible :year, :month, :day, :entity, :created_at, :updated_at
    belongs_to :entity, class_name: "Expand::Entity"
    has_many :click_rates, class_name: "Expand::ClickRate"

    def self.create_rate(date,entity)
      attribute={year: date.year, month: date.month, day: date.day, entity: entity}
      click_date=Expand::ClickDate.find_or_create_by(attribute)
      Expand::ClickRate.create!(click_date: click_date)
      click_date
    end
  end
end