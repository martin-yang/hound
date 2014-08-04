Hound::App.controllers "expand/units" do
  get "/:id/redirect" do
  	entity = Expand::Entity.find_by(key: params[:id])
  	return render "message/error" unless entity
  	entity.up_click_rate
    redirect entity.path
  end

  get "/had.json" do
    AboutUser::TakeHadExpandProducts.new(session[:current_user][:username]).execute(params[:page]).to_json
  end

  post :create do
    Product::CreateExpandProduct.new(params[:unit],params[:place_name],params[:expand_request_id]).execute.to_json
  end

  get :show do
    Expand::Entity.find(params[:id]).to_json
  end
end