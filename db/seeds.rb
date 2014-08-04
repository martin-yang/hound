# -*- coding: utf-8 -*-
[{name: "网站",view_key: "网站名称"},
  {name: "APP",view_key: "应用名称"},
  {name: "导购",view_key: "媒体类型"}].each do |key|
  CustomField::Main.create!(name: key[:name],view_key: key[:view_key])
end
#网站--------------------------
form=CustomField::Form.create!(main: CustomField::Main.first)
[{name: "网站名称",type: "text"},{name: "网站域名",type: "text"},
  {name: "网站类型",type: "select"},{name: "网站描述",type: "textarea"},
{name: "备案信息",type: "text"}].each do |field|
  CustomField::Field.create!(form: form,name: field[:name],category: field[:type])
end
select_field=CustomField::Field.find_by_name("网站类型")
select_value=["网址站","导购分享","返利","论坛","社交网站","休闲娱乐","生活服务","门户网站","新闻媒体","行业企业","体育健身","医疗健康","交通旅游","金融"]
CustomField::DefaultValue.create(value: select_value,field: select_field)
input_field=CustomField::Field.find_by_name("网站域名")
input_value=["http://"]
CustomField::DefaultValue.create(value: input_value,field: input_field)

#APP--------------------------
form=CustomField::Form.create!(main: CustomField::Main.find_by_name("APP"))
[{name: "应用名称",type: "text"},{name: "应用包名",type: "text"},
  {name: "下载地址",type: "text"},{name: "应用类型",type: "select"},
{name: "操作平台",type: "radio"},{name: "应用简介",type: "textarea"}].each do |field|
  CustomField::Field.create!(form: form,name: field[:name],category: field[:type])
end
select_field=CustomField::Field.find_by_name("应用类型")
select_value=["图书","导航","娱乐","健康","财务","影像","游戏","商业","教育","音乐","生活","天气","参考","美食","社交","体育","效率","工具","旅行","医疗","阅读","网址导航","返利","分享导购"]
CustomField::DefaultValue.create(value: select_value,field: select_field)
radio_field=CustomField::Field.find_by_name("操作平台")
radio_value=["安卓","苹果","微软","其他"]
CustomField::DefaultValue.create(value: radio_value,field: radio_field)
input_field=CustomField::Field.find_by_name("下载地址")
input_value=["http://"]
CustomField::DefaultValue.create(value: input_value,field: input_field)
#导购--------------------------
form=CustomField::Form.create!(main: CustomField::Main.find_by_name("导购"))
[{name: "导购类型",type: "select"},{name: "媒体类型",type: "select"},
  {name: "账号",type: "text"}].each do |field|
  CustomField::Field.create!(form: form,name: field[:name],category: field[:type])
end
select_field=CustomField::Field.find_by_name("导购类型")
select_value=["聊天工具","分享","代购"]
CustomField::DefaultValue.create(value: select_value,field: select_field)
select_field=CustomField::Field.find_by_name("媒体类型")
select_value=["QQ","YY","飞信","易信","Skype","来往"]
CustomField::DefaultValue.create(value: select_value,field: select_field)
