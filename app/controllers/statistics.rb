Hound::App.controllers "statistics" do
  get "/of_graph.json" do
    Statistics::TakeClickRatesOfMonth.new(Time.now).execute(session[:current_user][:username]).to_json
  end

  get "/of_brand.json" do
    Statistics::TakeBrandsClickRates.execute[0,9].to_json
  end

  get "/of_product.json" do
    Statistics::TakeProductsClickRates.execute[0,9].to_json
  end
end