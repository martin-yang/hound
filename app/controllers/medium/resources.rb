Hound::App.controllers "medium/resources" do
  
  get "/of_resource_desc.json" do
  	Medium::Resource.all_of_desc(session[:current_user][:username]).to_json
  end

  get :index do
  	CustomField::Main.all.to_json
  end

  get "/:id/of_form.json" do
    main = CustomField::Main.find(params[:id]) rescue nil
    return CustomField::Main.all.first.to_json unless main
    main.to_json
  end

  get "/:id/of_field_table.json" do
    CustomField::Main.find(params[:id]).table_content(session[:current_user][:username]).to_json
  end

  get "/:id/form_fields.json" do
    (CustomField::Main.find(params[:id]).form.fields_to_html rescue []).to_json
  end

  post :create do
    CreateMediumExpand.execute(params[:form_id],params[:medium_resource],session[:current_user][:username]).to_json
  end
end
