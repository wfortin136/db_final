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

ActiveRecord::Schema.define(version: 0) do

  create_table "champhists", force: :cascade do |t|
    t.integer "promotion_id",   limit: 4
    t.integer "weightclass_id", limit: 4
    t.integer "fighter_id",     limit: 4
    t.date    "start"
    t.date    "end"
  end

  add_index "champhists", ["fighter_id"], name: "index_champhists_on_fighter_id", using: :btree
  add_index "champhists", ["promotion_id"], name: "index_champhists_on_promotion_id", using: :btree
  add_index "champhists", ["weightclass_id"], name: "index_champhists_on_weightclass_id", using: :btree

  create_table "fightcards", force: :cascade do |t|
    t.string  "promotion_id",  limit: 255
    t.string  "fightcardName", limit: 255
    t.integer "locID",         limit: 4
    t.date    "date"
  end

  add_index "fightcards", ["promotion_id"], name: "index_fightcards_on_promotion_id", using: :btree

  create_table "fighters", force: :cascade do |t|
    t.string  "fighterName", limit: 255
    t.integer "wins",        limit: 4
    t.integer "losses",      limit: 4
    t.integer "draws",       limit: 4
    t.integer "nc",          limit: 4
  end

  create_table "fights", force: :cascade do |t|
    t.integer "fightcard_id",   limit: 4
    t.integer "fightNum",       limit: 4
    t.integer "weightclass_id", limit: 4
    t.integer "cardLevel",      limit: 4
    t.integer "championship",   limit: 4
    t.integer "fightTime",      limit: 4
    t.string  "method",         limit: 255
  end

  add_index "fights", ["fightcard_id"], name: "index_fights_on_fightcard_id", using: :btree
  add_index "fights", ["weightclass_id"], name: "index_fights_on_weightclass_id", using: :btree

  create_table "fightstats", force: :cascade do |t|
    t.integer "fight_id",   limit: 4
    t.integer "fighter_id", limit: 4
    t.integer "round",      limit: 4
    t.integer "kd",         limit: 4
    t.integer "str_landed", limit: 4
    t.integer "str_thrown", limit: 4
    t.integer "td_att",     limit: 4
    t.integer "td_com",     limit: 4
    t.integer "sub_att",    limit: 4
  end

  add_index "fightstats", ["fight_id"], name: "index_fightstats_on_fight_id", using: :btree
  add_index "fightstats", ["fighter_id"], name: "index_fightstats_on_fighter_id", using: :btree

  create_table "judges", force: :cascade do |t|
    t.string "judgeName", limit: 255
  end

  create_table "judgescores", force: :cascade do |t|
    t.integer "judge_id",   limit: 4
    t.integer "fight_id",   limit: 4
    t.integer "fighter_id", limit: 4
    t.integer "round",      limit: 4
    t.integer "score",      limit: 4
  end

  add_index "judgescores", ["fight_id"], name: "index_judgescores_on_fight_id", using: :btree
  add_index "judgescores", ["fighter_id"], name: "index_judgescores_on_fighter_id", using: :btree
  add_index "judgescores", ["judge_id"], name: "index_judgescores_on_judge_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string "city",    limit: 255
    t.string "state",   limit: 255
    t.string "country", limit: 255
  end

  create_table "promotions", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string  "name",            limit: 255
    t.string  "email",           limit: 255
    t.boolean "admin",           limit: 1,   default: false
    t.string  "password_digest", limit: 255
  end

  create_table "weightclasses", force: :cascade do |t|
    t.string  "className", limit: 255
    t.integer "weight",    limit: 4
  end

end
