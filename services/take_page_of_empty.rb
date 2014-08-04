class TakePageOfEmpty
  def self.execute(page)
    return 1 if page.nil? || page.empty?
    page.to_i rescue 1
  end
end