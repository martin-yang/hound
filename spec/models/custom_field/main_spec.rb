# -*- coding: utf-8 -*-
require 'spec_helper'

describe "custom type" do
  before do
  	[:website,:app,:message].each do |k|
  		FactoryGirl.create(k)
  	end
  end
  
  it "test take custom size" do
  	CustomField::Main.all.size.should == 3
  end

end