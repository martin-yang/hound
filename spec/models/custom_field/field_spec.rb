# -*- coding: utf-8 -*-
require 'spec_helper'
describe CustomField::Field do
  before do
  	[:website_form_field,:app_form_field,:message_form_field].each do |k|
  		FactoryGirl.create(k)
  	end
  end

  it "test custom field convert to html" do
  	CustomField::Field.find_by(category: "text").to_html.should == %Q(<input name="test" class="form-control"  type="text" value="" placeholder="必填项" required="required"/>)
    CustomField::Field.find_by(category: "select").to_html.should == %Q(<select class="form-control" name="test"></select>)
    CustomField::Field.find_by(category: "textarea").to_html.should == %Q(<textarea name="test" class="form-control"  rows="4" cols="50" placeholder="必填项" required="required"></textarea>)
  end

  it "test add default value in field of type is text" do
    CustomField::Field.find_by(category: "text").add_default_value(["http://"])
    CustomField::Field.find_by(category: "text").to_html.should == %Q(<input name="test" class="form-control"  type="text" value="http://" placeholder="必填项" required="required"/>)
  end

  it "test add default value in field of type is select" do
    CustomField::Field.find_by(category: "select").add_default_value(["a"])
    CustomField::Field.find_by(category: "select").to_html.should == %Q(<select class="form-control" name="test"><option value="a">a</option></select>)
  end

  it "test add default value in field of type is textarea" do
    CustomField::Field.find_by(category: "textarea").add_default_value(["a"])
    CustomField::Field.find_by(category: "textarea").to_html.should == %Q(<textarea name="test" class="form-control"  rows="4" cols="50" placeholder="必填项" required="required">a</textarea>)
  end

  it "test add default value in field of type is radio" do
    CustomField::Field.create(name: "test", category: "radio")
    CustomField::Field.find_by(category: "radio").add_default_value(["a","b"])
    CustomField::Field.find_by(category: "radio").to_html.should == %Q(<input class="form-control" type="radio" name="test" value="a"/><span>a</span><input class="form-control" type="radio" name="test" value="b"/><span>b</span>)
  end

end