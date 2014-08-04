FactoryGirl.define do
  factory :place,class: Expand::Place do
    name "test expand place"
  end

  factory :brand,class: Expand::Brand do
    name "test expand brand"
  end

  factory :entity,class: Expand::Entity do
    expand_type "商品推广"
    path "http://127.0.0.1:3000"
    new_path "#{BuildExpandAttribute.of_new_path(Expand::Entity.key)}"
    text_path "#{BuildExpandAttribute.of_text_path(BuildExpandAttribute.of_new_path(Expand::Entity.key),'test expand entity')}"
    img_path "#{BuildExpandAttribute.of_img_path(BuildExpandAttribute.of_new_path(Expand::Entity.key),'/image_path','test expand entity')}"
    association :place, factory: :place
    association :brand, factory: :brand
  end

end