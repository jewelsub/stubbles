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

ActiveRecord::Schema.define(:version => 20120302151222) do

  create_table "project_memberships", :force => true do |t|
    t.integer "project_id",                   :null => false
    t.integer "user_id",                      :null => false
    t.string  "role",                         :null => false
    t.boolean "active",     :default => true
  end

  add_index "project_memberships", ["project_id"], :name => "index_project_memberships_on_project_id"
  add_index "project_memberships", ["user_id"], :name => "index_project_memberships_on_user_id"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "started_on"
    t.integer  "creator_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "stories", :force => true do |t|
    t.string   "title"
    t.string   "status"
    t.string   "scope",          :default => "backlog"
    t.text     "description"
    t.integer  "project_id"
    t.integer  "assigned_to_id"
    t.integer  "priority"
    t.date     "start_at"
    t.date     "complete_at"
    t.date     "deadline"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  add_index "stories", ["assigned_to_id"], :name => "index_stories_on_assigned_to_id"
  add_index "stories", ["project_id"], :name => "index_stories_on_project_id"

  create_table "tasks", :force => true do |t|
    t.string   "title"
    t.string   "status"
    t.integer  "story_id"
    t.integer  "assigned_to_id"
    t.float    "hours_estimated"
    t.float    "hours_spent"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "tasks", ["story_id"], :name => "index_tasks_on_story_id"

  create_table "time_entries", :force => true do |t|
    t.float    "hours_spent"
    t.date     "spent_on"
    t.integer  "user_id"
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
