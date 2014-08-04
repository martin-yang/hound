class MyExpandRequest
  attr_accessor :user

  def initialize(username)
    self.user = (User.find_by(username: username) rescue nil)
  end

  def execute
    return [] if self.user.nil?
    self.user.expand_requests.map{|er|
      attribute = er.attributes
      attribute["expand_num"] = er.entities.size
      attribute
    }
  end
end