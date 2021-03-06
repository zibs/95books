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

ActiveRecord::Schema.define(version: 20150717185737) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string   "author"
    t.string   "title"
    t.string   "publisher"
    t.boolean  "displayable"
    t.string   "hashed_book"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "reader_id"
  end

  add_index "books", ["reader_id"], name: "index_books_on_reader_id", using: :btree

  create_table "books_readers", id: false, force: :cascade do |t|
    t.integer "book_id"
    t.integer "reader_id"
  end

  create_table "readers", force: :cascade do |t|
    t.string   "name"
    t.text     "tweet_content",              array: true
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_foreign_key "books", "readers"
end
