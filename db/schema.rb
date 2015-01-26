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

ActiveRecord::Schema.define(version: 20150126062314) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "categories", ["project_id"], name: "index_categories_on_project_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "discussion_id"
  end

  add_index "comments", ["discussion_id"], name: "index_comments_on_discussion_id", using: :btree

  create_table "discussions", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "project_id"
  end

  add_index "discussions", ["project_id"], name: "index_discussions_on_project_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.date     "due_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "title"
    t.date     "due_date"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "project_id"
    t.boolean  "status",     default: false
    t.text     "body"
  end

  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id", using: :btree

  add_foreign_key "categories", "projects"
  add_foreign_key "comments", "discussions"
  add_foreign_key "discussions", "projects"
  add_foreign_key "tasks", "projects"
end
