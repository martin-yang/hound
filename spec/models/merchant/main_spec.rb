# -*- coding: utf-8 -*-
require 'spec_helper'
describe "merchant" do
  it "take had products" do
  	(Merchant.had_products("408290909@qq.com",Login::SessionKey.new.go["uuid"],1)[:list].size > 0).should == true
  end

  describe "merchant set a product for expand" do
    before do
      @user=User.find_or_create_by(username: "408290909@qq.com")
      @product=Merchant.had_products(@user.username,Login::SessionKey.new.go["uuid"],1)[:list].first
    end

    it "a product need expand" do
      Merchant::ExpandRequest.create!({name: "test product", img: "xxx", price: 12.0, commission: 12, user: @user, product_id: "123"})
      Merchant::ExpandRequest.all.first.product_id.should == "123"
    end
  end

  describe "set a product for expand request from call baihuogou api" do
    before do
      session_key=Login::SessionKey.new.go["uuid"]
      @products=Product::SearchProducts.new("a",1,session_key).execute["list"]
      @product=Product::FindProduct.new(@products.first["product_id"],session_key).execute
    end

    it "add expand request" do
      @product.add_expand_request({"commission" => 12},"408290909@qq.com")
      Merchant::ExpandRequest.last.name.should == @product["product"]["product_name"]
      Merchant::ExpandRequest.last.brand_name.should == @product["product"]["brand_name"]
      Merchant::ExpandRequest.last.list_price.should == @product["product"]["product_price"]["listPrice"]
      Merchant::ExpandRequest.last.default_price.should == @product["product"]["product_price"]["defaultPrice"]
      Merchant::ExpandRequest.last.img.should == (I18n.t 'image',image_path: @product["product"]["large_image_url"])
    end
  end

  describe "take products from store" do
    before do
      engine = Login::Engine.new("408290909@qq.com","yang408290909")
      @session_key = engine.take_key["uuid"]
      @result = engine.login(@session_key)
    end

    it "take products form store of merchant" do
      Product::TakePreferredProducts.new(24,@result["website_id"],@session_key).execute
    end
  end

end