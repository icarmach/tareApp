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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130417205746) do

  create_table "archives", :force => true do |t|
    t.string   "name"
    t.integer  "version"
    t.integer  "homework_user_id"
    t.string   "ip"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "path"
  end

  create_table "homeworks", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "path"
    t.string   "description"
    t.boolean  "active"
    t.datetime "deadline"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "lastname"
    t.integer  "deleted"
    t.boolean  "admin"
    t.string   "hash_password"
    t.string   "salt"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "token"
  end

end
