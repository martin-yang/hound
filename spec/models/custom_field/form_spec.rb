# -*- coding: utf-8 -*-
require 'spec_helper'

describe CustomField::Form do
  before do
  	[:website_form,:app_form,:message_form].each do |k|
  		FactoryGirl.create(k)
  	end
  end
  
  it "test custom type have a form" do
  	CustomField::Main.all.each do |m|
  	  m.form.should_not == nil
  	end
  end

end