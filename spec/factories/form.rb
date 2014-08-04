FactoryGirl.define do
  factory :website_form,class: CustomField::Form do
    association :main, factory: :website
  end

  factory :app_form,class: CustomField::Form do
    association :main, factory: :app
  end

  factory :message_form,class: CustomField::Form do
    association :main, factory: :message
  end

end