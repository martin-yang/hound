FactoryGirl.define do
  factory :website_form_field,class: CustomField::Field do
    name "test"
    category "text"
    association :form, factory: :website_form
  end

  factory :app_form_field,class: CustomField::Field do
    name "test"
    category "select"
    association :form, factory: :app_form
  end

  factory :message_form_field,class: CustomField::Field do
    name "test"
    category "textarea"
    association :form, factory: :message_form
  end

end