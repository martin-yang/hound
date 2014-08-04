# -*- coding: utf-8 -*-
require 'spec_helper'
describe Expand::Entity do
  before do
  	FactoryGirl.create(:entity)
  	FactoryGirl.create(:website_form_field)
  	Medium::Resource.create_of_form_content(CustomField::Main.first,{"test" => "value"})
    Expand::Place.first.update_attributes(resource: Medium::Resource.first)
  	Expand::Entity.first.update_attributes(resource: Medium::Resource.first)
  end

  it "test resource have a entity(expand product)" do
  	Medium::Resource.first.entities.first.should == Expand::Entity.first
  end

  it "test add expand entity(product) and have a expand place and a brand" do
  	entity=Expand::Entity.first
  	entity.place.name.should == "test expand place"
  	entity.brand.name.should == "test expand brand"
  end

  describe "test call baihuogou search api" do
    before do
      FactoryGirl.create(:expand_request)
      # session_key=Login::SessionKey.new.go["uuid"]
      # @products=Search::Product.all("a",session_key,page: 1)["list"]
      # @product=Search::Product.by(@products.first["product_id"],session_key)
      @product=Merchant::ExpandRequest.all.first
    end

  	it "expand a really product" do
      @product.expand({"resource_id" => Medium::Resource.first.id, "place_id" => Expand::Place.first.id,  "expand_type" => "商品推广"})
      entity = Expand::Entity.last
      path = %Q(http://127.0.0.1:3000/expand/units/#{Expand::Entity.key(Expand::Entity.all.size)}/redirect)
      Expand::Entity.all.size.should == 2
      entity.expand_request.name.should == "test product"
      Medium::Resource.first.entities.last.should == entity
      Expand::Place.last.entities.last.should == entity
      entity.path.should == %Q(http://www.100hg.com/product/#{@product.product_id}.html)
      entity.new_path.should == path
      entity.img_path.should == %Q(<a href="#{path}" target="_blank"><img src="http://file.100hg.com#{@product.img}"/><div>#{@product.name}</div></a>)
      entity.text_path.should == %Q(<a href="#{path}" target="_blank">#{@product.name}</a>)
  	end

  end

end