FactoryGirl.define do

  factory :expand_request,class: Merchant::ExpandRequest do
    name "test product"
    product_id "123"
    brand_name "test brand"
    img "img"
    list_price 25.8
    default_price 22.5
    commission 12
    association :user, factory: :user
  end

end