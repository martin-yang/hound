Hound::App.controllers "admin/users" do
  get :index do
  	page = TakePageOfEmpty.execute(params[:page])
    Statistics::ExpandParticipator.new(page).execute.to_json
  end
end