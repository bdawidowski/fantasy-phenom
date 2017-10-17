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

ActiveRecord::Schema.define(version: 20171017032114) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "slug"
    t.integer  "user_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "approved",           default: false
  end

  add_index "articles", ["slug"], name: "index_articles_on_slug", unique: true, using: :btree

  create_table "charges", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "stripe_id"
    t.integer  "amount"
    t.string   "status"
    t.string   "card_last4"
    t.string   "card_type"
    t.string   "card_exp_month"
    t.string   "card_exp_year"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "charges", ["stripe_id"], name: "index_charges_on_stripe_id", unique: true, using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "googlesheets", force: :cascade do |t|
    t.string   "sport"
    t.string   "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "date_for"
    t.boolean  "status"
  end

  create_table "standings", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "stripe_id"
    t.datetime "current_period_end"
    t.datetime "current_period_start"
    t.datetime "canceled_at"
    t.string   "status"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.datetime "ended_at"
    t.datetime "trial_start"
    t.datetime "trial_end"
    t.string   "discount"
  end

  add_index "standings", ["stripe_id"], name: "index_standings_on_stripe_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                  default: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "stripe_id"
    t.string   "stripe_subscription_id"
    t.string   "card_last4"
    t.string   "card_exp_month"
    t.string   "card_exp_year"
    t.string   "card_type"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.boolean  "subscribed",             default: false
    t.boolean  "was_subscribed",         default: false
    t.boolean  "chatroom",               default: false
    t.string   "rocket_token"
    t.string   "rocket_pw"
    t.boolean  "editor",                 default: false
    t.boolean  "paypal",                 default: false
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "contributor",            default: false
    t.string   "amount",                 default: "0.00"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
