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

ActiveRecord::Schema.define(version: 20170417213912) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "infection_reports", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "reporter_id"
    t.integer  "infected_id"
    t.index ["infected_id"], name: "index_infection_reports_on_infected_id", using: :btree
    t.index ["reporter_id"], name: "index_infection_reports_on_reporter_id", using: :btree
  end

  create_table "inventories", force: :cascade do |t|
    t.integer  "quantity"
    t.integer  "item_id"
    t.integer  "survivor_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["item_id"], name: "index_inventories_on_item_id", using: :btree
    t.index ["survivor_id"], name: "index_inventories_on_survivor_id", using: :btree
  end

  create_table "items", force: :cascade do |t|
    t.string  "description"
    t.integer "points"
  end

  create_table "survivors", force: :cascade do |t|
    t.string   "name"
    t.integer  "age"
    t.string   "gender",         limit: 1
    t.string   "last_latitude"
    t.string   "last_longitude"
    t.boolean  "infected"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

end
