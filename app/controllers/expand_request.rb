Hound::App.controllers "expand_request" do
  get :new do
  	Merchant::ExpandRequest.new.to_json
  end

  post :create do
    product=Product::FindProduct.new(params["product_id"],session[:current_user][:key]).execute
    product.add_expand_request(params[:expand_request],session[:current_user][:username]).to_json
  end

  get :index do
    MyExpandRequest.new(session[:current_user][:username]).execute.to_json
  end
end