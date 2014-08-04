# -*- coding: utf-8 -*-
require 'spec_helper'
describe "Expand::UnitsController" do
  before do
  	FactoryGirl.create(:entity)
  	FactoryGirl.create(:website_form_field)
  	Medium::Resource.create_of_form_content(CustomField::Main.first,{"test" => "value"})
  	Expand::Entity.first.update_attributes(resource: Medium::Resource.first)
  	FactoryGirl.create(:expand_request)
    @product=Merchant::ExpandRequest.all.first
    @product.expand({"resource_id" => Medium::Resource.first.id, "place_id" => Expand::Place.first.id,  "expand_type" => "商品推广"})
  end

  it "test visit new path" do
    get "/expand/units/#{Expand::Entity.key(Expand::Entity.all.size)}/redirect"
    Expand::Entity.last.click_rates.should == 1
  end

  it "take expand products" do
    result = (get "/expand/units/had.json")
    result.body.should == {page: {},list: []}.to_json
  end
end