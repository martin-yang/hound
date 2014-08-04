module Statistics
  class TakeClickRatesOfDate
    def self.execute(entities)
      {sum: entities.inject(0){|sum,e| sum+e.click_rates},
      three_days: date_scope(build_start_time(Time.now-2.days),build_end_time(Time.now),entities),
      seven_days: date_scope(build_start_time(Time.now-6.days),build_end_time(Time.now),entities),
      thirty_days: date_scope(build_start_time(Time.now-29.days),build_end_time(Time.now),entities)}
    end

    private
    def self.date_scope(start_date,end_date,entities)
      return 0 if entities.size.eql?(0)
      click_dates=Expand::ClickDate.find_by_sql("select * from expand_click_dates where entity_id in (#{entities.map(&:id).join(",")}) and created_at >= '#{start_date.strftime("%Y-%m-%d %H:%M:%S")}' and created_at<='#{end_date.strftime("%Y-%m-%d %H:%M:%S")}'")
      click_dates.inject(0){|sum,cd| sum+cd.click_rates.size}
    end

    def self.build_start_time(date)
      Time.local(date.year,date.month,date.day,0,0,0)
    end

    def self.build_end_time(date)
      Time.local(date.year,date.month,date.day,12,59,59)
    end
  end
end