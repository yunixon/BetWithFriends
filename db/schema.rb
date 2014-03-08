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

ActiveRecord::Schema.define(version: 20140308072540) do

  create_table "bets", force: true do |t|
    t.datetime "date_time"
    t.integer  "match_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "crews", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.integer  "stage_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", force: true do |t|
    t.datetime "date"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "team_a_id"
    t.integer  "team_b_id"
  end

  create_table "results", force: true do |t|
    t.integer  "score_team_a"
    t.integer  "score_team_b"
    t.string   "resultable_type"
    t.integer  "resultable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "played"
  end

  create_table "stages", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "standings", force: true do |t|
    t.integer  "played"
    t.integer  "won"
    t.integer  "draw"
    t.integer  "lost"
    t.integer  "goals_for"
    t.integer  "goals_against"
    t.integer  "points"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email_address"
    t.string   "password"
    t.integer  "crew_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
