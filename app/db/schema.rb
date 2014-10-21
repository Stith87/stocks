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

ActiveRecord::Schema.define(version: 20141019012556) do

  create_table "historical", force: true do |t|
    t.string  "symbol",    limit: 5
    t.date    "date"
    t.decimal "open",                precision: 2, scale: 0
    t.decimal "high",                precision: 2, scale: 0
    t.decimal "low",                 precision: 2, scale: 0
    t.decimal "close",               precision: 2, scale: 0
    t.integer "volume"
    t.decimal "adj_close",           precision: 2, scale: 0
  end



  create_table "stock_data", force: true do |t|
    t.decimal  "ask",                  precision: 2, scale: 0
    t.integer  "asksz"
    t.decimal  "bid",                  precision: 2, scale: 0
    t.integer  "bidsz"
    t.datetime "datetime"
    t.string   "exch",      limit: 45
    t.decimal  "last",                 precision: 3, scale: 0
    t.string   "symbol",    limit: 5
    t.string   "timestamp", limit: 45
  end

  add_index "stock_data", ["id"], name: "id_UNIQUE", unique: true

end
