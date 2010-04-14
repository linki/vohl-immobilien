# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090131175017) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  create_table "contact_messages", :force => true do |t|
    t.string   "name"
    t.string   "company"
    t.string   "email"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "recipient"
  end

  create_table "contact_people", :force => true do |t|
    t.string   "name"
    t.string   "position"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_url"
  end

  create_table "downloads", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "url"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "floorplans", :force => true do |t|
    t.string   "name"
    t.string   "kind"
    t.string   "location"
    t.string   "status"
    t.string   "file_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price_per_meter", :precision => 8, :scale => 2
    t.decimal  "full_price",      :precision => 8, :scale => 2
    t.integer  "square_meters"
    t.integer  "position"
  end

  create_table "items", :force => true do |t|
    t.string   "type"
    t.string   "name"
    t.string   "permalink"
    t.text     "content"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_items", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id",  :default => 0, :null => false
    t.integer  "position"
    t.integer  "page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  add_index "menu_items", ["parent_id"], :name => "index_menu_items_on_parent_id"

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "permalink",  :default => "index", :null => false
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["permalink"], :name => "index_pages_on_permalink", :unique => true

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "salutation"
    t.string   "phone"
    t.string   "company"
    t.string   "reset_code",                :limit => 40
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
