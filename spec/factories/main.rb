FactoryGirl.define do
  factory :website,class: CustomField::Main do
    name '网站'
    view_key '网站名称'
  end

  factory :app,class: CustomField::Main do
    name 'APP'
    view_key '应用名称'
  end

  factory :message,class: CustomField::Main do
    name '导购'
    view_key '媒体类型'
  end

end