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

ActiveRecord::Schema.define(:version => 20091031003344) do

  create_table "albums", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "cover_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title_image_file_name"
    t.string   "title_image_content_type"
    t.integer  "title_image_file_size"
    t.datetime "title_image_updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "author"
    t.string   "author_url"
    t.string   "author_email"
    t.text     "content"
    t.boolean  "spam",         :default => false
    t.string   "user_ip"
    t.string   "user_agent"
    t.string   "referrer"
    t.integer  "photo_id"
    t.datetime "view_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.integer  "icq"
    t.integer  "contactable_id"
    t.string   "contactable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.text     "place"
    t.text     "description"
    t.datetime "start_at"
    t.datetime "view_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.string   "description"
    t.integer  "album_id"
    t.datetime "deleted_at"
    t.integer  "comments_count",     :default => 0
    t.integer  "position"
    t.boolean  "bathe",              :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "processing",         :default => true
  end

  create_table "purchases", :force => true do |t|
    t.integer  "photo_id"
    t.text     "description"
    t.datetime "view_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "value"
    t.integer  "photo_id"
    t.string   "user_ip"
    t.string   "user_agent"
    t.datetime "created_at"
  end

  add_index "ratings", ["photo_id"], :name => "index_ratings_on_photo_id"

end
