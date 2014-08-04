Hound::App.controllers "link_manage" do
  before do
    @user=User.find_by(username: session[:current_user][:username]) rescue nil
    halt Prompt.error_500.to_json unless @user
  end

  get "/convert.json" do
    GenerateExpandLink.execute(params[:convert_link],@user).to_json
  end
end