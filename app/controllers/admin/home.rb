Hound::App.controllers "admin/home" do
  get "/sum.json" do
    Statistics::TakeClickRatesOfDate.execute(Expand::Entity.all).to_json
  end
end