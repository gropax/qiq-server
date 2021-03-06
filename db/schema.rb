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

ActiveRecord::Schema.define(version: 20141231213205) do

  create_table "buffers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "note_bufferings", force: true do |t|
    t.integer  "note_id"
    t.integer  "buffer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "note_bufferings", ["buffer_id"], name: "index_note_bufferings_on_buffer_id"
  add_index "note_bufferings", ["note_id"], name: "index_note_bufferings_on_note_id"

  create_table "note_taggings", force: true do |t|
    t.integer  "note_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "note_taggings", ["note_id"], name: "index_note_taggings_on_note_id"
  add_index "note_taggings", ["tag_id"], name: "index_note_taggings_on_tag_id"

  create_table "notes", force: true do |t|
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
