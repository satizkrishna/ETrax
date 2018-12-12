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

ActiveRecord::Schema.define(version: 20181203220057) do

  create_table "expense_cycles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "owner_id", null: false
    t.string "title", null: false
    t.text "description"
    t.string "type", null: false
    t.datetime "starts_at"
    t.datetime "expires_at"
    t.float "spends", limit: 24
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type", "owner_id", "is_active"], name: "exp_cyc_actv_idx"
    t.index ["type", "owner_id"], name: "index_expense_cycles_on_type_and_owner_id"
  end

  create_table "expense_profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id", null: false
    t.float "funds", limit: 24, default: 0.0
    t.integer "starts_at_day", default: 1
    t.boolean "can_alert", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_expense_profiles_on_user_id"
  end

  create_table "expense_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "creator_id"
    t.string "title", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_expense_types_on_creator_id"
  end

  create_table "expenses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "type", null: false
    t.string "title", null: false
    t.text "description"
    t.integer "owner_id", null: false
    t.integer "parent_id"
    t.integer "cycle_id", null: false
    t.string "cycle_type", null: false
    t.float "total_spends", limit: 24, default: 0.0
    t.float "expected_spends", limit: 24, default: 0.0
    t.float "recovered_spends", limit: 24, default: 0.0
    t.integer "expense_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type", "cycle_id", "cycle_type"], name: "exp_cyc_poly_idx"
    t.index ["type", "owner_id"], name: "index_expenses_on_type_and_owner_id"
    t.index ["type", "parent_id"], name: "index_expenses_on_type_and_parent_id"
  end

  create_table "participants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "participant_id", null: false
    t.integer "cycle_id", null: false
    t.float "total_due", limit: 24, default: 0.0
    t.float "total_owe", limit: 24, default: 0.0
    t.index ["participant_id", "cycle_id"], name: "patcp_main_map_idx"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "uname"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.text "authentication_token"
    t.datetime "authentication_token_created_at"
    t.datetime "last_alert_sent_at"
    t.datetime "last_visit_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true, length: { authentication_token: 10 }
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
