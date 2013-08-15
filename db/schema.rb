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

ActiveRecord::Schema.define(version: 20130813074827) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.string   "tag"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "addresses", force: true do |t|
    t.integer  "account_id"
    t.string   "label"
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "legacy_accounts", id: false, force: true do |t|
    t.integer "id",          limit: 8
    t.string  "account_tag"
    t.string  "book_name"
  end

  create_table "legacy_addresses", id: false, force: true do |t|
    t.integer "id",          limit: 8
    t.string  "account_tag"
    t.string  "label"
    t.string  "street1"
    t.string  "street2"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.string  "source"
    t.boolean "active"
  end

  create_table "legacy_mentions", id: false, force: true do |t|
    t.integer "id",                 limit: 8
    t.string  "account_tag"
    t.string  "sponsor_first_name"
    t.string  "sponsor_last_name"
    t.string  "yizkor_first_name"
    t.string  "yizkor_last_name"
    t.string  "publication_type"
    t.string  "publication_year"
  end

  create_table "legacy_payments", id: false, force: true do |t|
    t.integer  "id",          limit: 8
    t.string   "account_tag"
    t.decimal  "amount",                precision: 10, scale: 2
    t.datetime "paid_on"
  end

  create_table "legacy_people", id: false, force: true do |t|
    t.integer "id",                 limit: 8
    t.string  "account_tag"
    t.string  "sponsor_first_name"
    t.string  "sponsor_last_name"
    t.string  "yizkor_first_name"
    t.string  "yizkor_last_name"
    t.string  "relationship"
    t.string  "source"
    t.integer "sort_order",         limit: 8
    t.string  "old_sort_order"
  end

  create_table "mentions", force: true do |t|
    t.integer  "mentionable_id"
    t.string   "mentionable_type"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "source"
  end

  create_table "payments", force: true do |t|
    t.integer  "account_id"
    t.decimal  "amount",     precision: 8, scale: 2
    t.date     "paid_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.string   "source"
  end

  create_table "people", force: true do |t|
    t.integer  "account_id"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "sort_order"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "ref_book_publication_2012", id: false, force: true do |t|
    t.integer "id",                limit: 8
    t.string  "last_name"
    t.string  "account_number"
    t.string  "sort_order"
    t.string  "yiskor_last_name"
    t.string  "yiskor_first_name"
    t.string  "book_name"
    t.string  "included_type"
    t.string  "included_year"
    t.boolean "active_flag"
  end

  create_table "ref_holocaust_publication_2012", id: false, force: true do |t|
    t.integer "id",                               limit: 8
    t.string  "last_name"
    t.string  "tbl_persons_final_account_number"
    t.string  "tbl_yiskors_final_account_number"
    t.string  "book_name"
    t.string  "included_type"
    t.string  "included_year"
    t.boolean "active_flag"
  end

  create_table "ref_in_2012_but_out_2013", id: false, force: true do |t|
    t.integer "id",             limit: 8
    t.string  "account_number"
    t.string  "book_name"
  end

  create_table "ref_labels_first_round_2013", id: false, force: true do |t|
    t.integer "id",                              limit: 8
    t.string  "last_name"
    t.string  "account_number"
    t.string  "mailing_label"
    t.string  "or_current_resident"
    t.string  "street_address"
    t.string  "street_address_detail"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.boolean "tbl_persons_final_active_flag"
    t.boolean "tbl_addresses_final_active_flag"
  end

  create_table "ref_letters_first_round_2013", id: false, force: true do |t|
    t.integer "id",                              limit: 8
    t.string  "account_number"
    t.string  "last_name"
    t.string  "book_name"
    t.string  "sort_order"
    t.string  "yiskor_last_name"
    t.string  "yiskor_first_name"
    t.string  "last_book"
    t.string  "last_holocaust"
    t.boolean "tbl_persons_final_active_flag"
    t.boolean "tbl_addresses_final_active_flag"
  end

  create_table "ref_letters_reminder_round_2013", id: false, force: true do |t|
    t.integer "id",                              limit: 8
    t.string  "last_name"
    t.string  "account_number"
    t.string  "book_name"
    t.string  "sort_order"
    t.string  "yiskor_last_name"
    t.string  "yiskor_first_name"
    t.string  "last_book"
    t.string  "last_holocaust"
    t.boolean "tbl_persons_final_active_flag"
    t.boolean "tbl_addresses_final_active_flag"
    t.string  "account_numbers_to_exclude"
  end

  create_table "ref_reminder_labels_2013", id: false, force: true do |t|
    t.integer "id",                              limit: 8
    t.string  "last_name"
    t.string  "account_number"
    t.string  "mailing_label"
    t.string  "or_current_resident"
    t.string  "street_address"
    t.string  "street_address_detail"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.boolean "tbl_persons_final_active_flag"
    t.boolean "tbl_addresses_final_active_flag"
    t.string  "exclude_accounts"
  end

  create_table "relationships", force: true do |t|
    t.integer  "sponsor_id"
    t.integer  "yizkor_id"
    t.string   "kind"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "account_id"
  end

  create_table "tbl_addresses_final", id: false, force: true do |t|
    t.integer  "first_ID",              limit: 8
    t.string   "account_number"
    t.string   "mailing_label"
    t.string   "street_address"
    t.string   "street_address_detail"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "source"
    t.integer  "how_many",              limit: 8
    t.datetime "created_on"
    t.boolean  "active_flag"
  end

  create_table "tbl_payments_final", id: false, force: true do |t|
    t.integer  "first_ID",          limit: 8
    t.string   "account_number"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "yiskor_first_name"
    t.string   "yiskor_last_name"
    t.float    "amount_paid"
    t.datetime "date_paid"
    t.integer  "how_many",          limit: 8
    t.datetime "created_on"
  end

  create_table "tbl_persons_final", id: false, force: true do |t|
    t.integer  "first_ID",          limit: 8
    t.string   "account_number"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "yiskor_first_name"
    t.string   "yiskor_last_name"
    t.string   "sort_order"
    t.string   "relationship"
    t.string   "book_name"
    t.integer  "how_many",          limit: 8
    t.datetime "created_on"
    t.string   "source"
    t.boolean  "active_flag"
  end

  create_table "tbl_yiskors_final", id: false, force: true do |t|
    t.integer  "first_ID",          limit: 8
    t.string   "account_number"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "yiskor_first_name"
    t.string   "yiskor_last_name"
    t.string   "included_type"
    t.string   "included_year"
    t.float    "how_many"
    t.datetime "created_on"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "name"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.datetime "deleted_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
