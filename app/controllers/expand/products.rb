Hound::App.controllers "expand/products" do
  get "/search.json" do
  	page = TakePageOfEmpty.execute(params[:page])
    Search::TakeExpandRequestProducts.new(params[:product],page).execute.to_json
  end

end