# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_01_30_122732) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "picture"
    t.string "country"
    t.boolean "mail_notifications", default: false
    t.string "lang", default: "en"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_accounts_on_confirmation_token", unique: true
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "start_date"
    t.float "balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "log_data"
  end

  create_table "activity_participants", force: :cascade do |t|
    t.bigint "activity_id", null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_activity_participants_on_account_id"
    t.index ["activity_id"], name: "index_activity_participants_on_activity_id"
  end

  create_table "automations", force: :cascade do |t|
    t.string "operator_class"
    t.bigint "configuration_id", null: false
    t.bigint "activity_id", null: false
    t.datetime "next_execution"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_automations_on_activity_id"
    t.index ["configuration_id"], name: "index_automations_on_configuration_id"
  end

  create_table "config_exceptions", force: :cascade do |t|
    t.string "value"
    t.bigint "configuration_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["configuration_id"], name: "index_config_exceptions_on_configuration_id"
  end

  create_table "configurations", force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.string "base"
    t.integer "range_amount"
    t.decimal "amount"
    t.boolean "automatic"
    t.string "preferred_day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "currencies", force: :cascade do |t|
    t.string "name"
    t.string "acronym"
    t.string "sign"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expenses", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "amount"
    t.bigint "activity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_expenses_on_activity_id"
  end

  create_table "incomes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "amount"
    t.bigint "activity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_incomes_on_activity_id"
  end

  create_table "user_currencies", force: :cascade do |t|
    t.bigint "currency_id", null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "main", default: false, null: false
    t.index ["account_id"], name: "index_user_currencies_on_account_id"
    t.index ["currency_id"], name: "index_user_currencies_on_currency_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "wishes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "estimation"
    t.decimal "priority"
    t.bigint "activity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_wishes_on_activity_id"
  end

  add_foreign_key "activity_participants", "accounts"
  add_foreign_key "activity_participants", "activities"
  add_foreign_key "automations", "activities"
  add_foreign_key "automations", "configurations"
  add_foreign_key "config_exceptions", "configurations"
  add_foreign_key "expenses", "activities"
  add_foreign_key "incomes", "activities"
  add_foreign_key "user_currencies", "accounts"
  add_foreign_key "user_currencies", "currencies"
  add_foreign_key "wishes", "activities"
end
