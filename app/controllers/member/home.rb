Hound::App.controllers "member/home" do
  before except: [] do
    @user = User.find_by(username: session[:current_user][:username]) rescue nil
    halt {}.to_json unless @user
  end

  get "/sum.json" do
    Statistics::TakeClickRatesOfDate.execute(Expand::Entity.where(resource_id: @user.resources.map(&:id))).to_json
  end
end