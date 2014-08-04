module Expand
  class ClickRate < ActiveRecord::Base
    attr_accessible :click_date, :created_at, :updated_at
    belongs_to :click_date, class_name: "Expand::ClickDate"
  end
end