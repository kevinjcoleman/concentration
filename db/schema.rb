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

ActiveRecord::Schema.define(version: 20161202013828) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_cards", force: :cascade do |t|
    t.string   "name"
    t.integer  "player_id"
    t.integer  "game_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "order"
    t.integer  "currently_picked_by_player_id"
    t.index ["currently_picked_by_player_id"], name: "index_game_cards_on_currently_picked_by_player_id", using: :btree
    t.index ["game_id"], name: "index_game_cards_on_game_id", using: :btree
    t.index ["player_id"], name: "index_game_cards_on_player_id", using: :btree
  end

  create_table "game_players", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "player_id"
    t.integer  "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_players_on_game_id", using: :btree
    t.index ["player_id"], name: "index_game_players_on_player_id", using: :btree
  end

  create_table "games", force: :cascade do |t|
    t.integer  "status_cd"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "player1_picks",  default: 0
    t.integer  "player2_picks",  default: 0
    t.integer  "turn_player_id"
    t.index ["turn_player_id"], name: "index_games_on_turn_player_id", using: :btree
  end

  create_table "players", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "playername"
    t.index ["email"], name: "index_players_on_email", unique: true, using: :btree
    t.index ["playername"], name: "index_players_on_playername", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_players_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "game_cards", "games"
  add_foreign_key "game_players", "games"
  add_foreign_key "game_players", "players"
end
