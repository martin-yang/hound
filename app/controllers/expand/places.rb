Hound::App.controllers "expand/places" do
  before except: ["/:id/content.json","/"] do
    @user=User.find_by(username: session[:current_user][:username]) rescue nil
    halt [].to_json unless @user
  end

  get "/of_user.json" do
    Expand::Place.where(resource_id: @user.resources.map(&:id)).to_json
  end

  get "/:id/content.json" do
    Statistics::TakePlacesExpandInfo.new(session[:current_user][:username],params[:id]).execute.to_json
  end

  get :index do
    Expand::Place.all.to_json
  end
end