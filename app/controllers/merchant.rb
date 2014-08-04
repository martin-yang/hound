Hound::App.controllers "merchant" do
  get "/products.json" do
  	page = TakePageOfEmpty.execute(params[:page])
  	Merchant.had_products(session[:current_user][:username],session[:current_user][:key],page).to_json
  end
end