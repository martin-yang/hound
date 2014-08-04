# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 1) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "custom_field_mains", force: true do |t|
    t.string "name"
    t.string "view_key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "custom_field_forms", force: true do |t|
    t.integer "main_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "custom_field_fields", force: true do |t|
    t.string "name"
    t.string "category"
    t.integer "form_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "custom_field_default_values", force: true do |t|
    t.string "value", :array => true
    t.integer "field_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medium_resources", force: true do |t|
    t.integer "main_id"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medium_contents", force: true do |t|
    t.string "name"
    t.text "value"
    t.integer "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string "username"
    t.string "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expand_entities", force: true do |t|
    # t.string "name"
    # t.string "logo"
    t.integer "expand_request_id"
    t.string "key"
    t.string "expand_type"
    t.string "path"
    t.string "new_path"
    t.string "text_path"
    t.string "img_path"
    t.integer "place_id"
    t.integer "brand_id"
    t.integer "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expand_places", force: true do |t|
    t.string "name"
    t.integer "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expand_brands", force: true do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expand_click_dates", force: true do |t|
    t.integer "entity_id"
    t.integer "year"
    t.integer "month"
    t.integer "day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expand_click_rates", force: true do |t|
    t.integer "click_date_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merchant_expand_requests", force: true do |t|
    t.integer "user_id"
    t.string "product_id"
    t.string "name"
    t.string "img"
    t.string "brand_name"
    t.float "list_price"
    t.float "default_price"
    t.integer "commission"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end
