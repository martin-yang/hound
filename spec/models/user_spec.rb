# -*- coding: utf-8 -*-
require 'spec_helper'
describe User do
  it "take login key" do
  	Login::SessionKey.new.go["message"].should == "SUCCESS"
  end

  it "user login" do
  	result=User.login("408290909@qq.com","yang408290909")#return value {key: "..",user: "408290909@qq.com"}
  	result[:user].should == "408290909@qq.com"
  end

  before do
  	FactoryGirl.create(:website_form_field)
  	FactoryGirl.create(:user)
  	Medium::Resource.create_of_form_content(CustomField::Main.first,{"test" => "value"},User.first)
  	Medium::Resource.create_of_form_content(CustomField::Main.first,{"test1" => "value1"})
  end

  it "test create medium by user" do
  	Medium::Resource.all.size.should == 2
  	User.first.resources.size.should == 1
  end
end