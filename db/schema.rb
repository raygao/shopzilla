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

ActiveRecord::Schema.define(:version => 20101120184659) do

  create_table "bon_marches", :force => true do |t|
    t.text     "brand"
    t.text     "category"
    t.text     "interest"
    t.text     "store"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "category_interests", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salesforce_category_interests", :force => true do |t|
    t.text     "Name"
    t.text     "Account__c"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shopzilla_top_tools", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
