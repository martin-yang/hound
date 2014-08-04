# -*- coding: utf-8 -*-
require 'spec_helper'
describe Medium::Resource do
  before do
  	FactoryGirl.create(:website_form_field)
  end

  it "test add resource content from form attributes" do
  	Medium::Resource.create_of_form_content(CustomField::Main.first,{"test" => "value"})
    content=Medium::Resource.first.contents.first
    content.name.should == "test"
    content.value.should == "value"
  end

end