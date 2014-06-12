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

ActiveRecord::Schema.define(version: 20140612061839) do

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "cloths_bills", force: true do |t|
    t.string   "customer_name"
    t.string   "service_name"
    t.string   "model"
    t.string   "mobile_number"
    t.decimal  "amount"
    t.decimal  "total"
    t.string   "bill_number"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cloths_bills", ["user_id"], name: "index_cloths_bills_on_user_id"

  create_table "courier_bills", force: true do |t|
    t.string   "sender"
    t.string   "sender_mobile_no"
    t.string   "receiver"
    t.string   "receiver_mobile_no"
    t.decimal  "amount"
    t.decimal  "total"
    t.string   "bill_number"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courier_bills", ["bill_number"], name: "index_courier_bills_on_bill_number", unique: true

  create_table "eb_bills", force: true do |t|
    t.string   "service_name"
    t.string   "service_number"
    t.string   "mobile_number"
    t.decimal  "amount"
    t.decimal  "total"
    t.string   "bill_number"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "emergency"
  end

  add_index "eb_bills", ["bill_number"], name: "index_eb_bills_on_bill_number", unique: true

  create_table "payments_bills", force: true do |t|
    t.string   "customer_name"
    t.string   "service_name"
    t.string   "network"
    t.string   "mobile_number"
    t.decimal  "amount"
    t.decimal  "total"
    t.string   "bill_number"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments_bills", ["bill_number"], name: "index_payments_bills_on_bill_number", unique: true
  add_index "payments_bills", ["user_id"], name: "index_payments_bills_on_user_id"

  create_table "service_bills", force: true do |t|
    t.string   "customer_name"
    t.string   "service_name"
    t.string   "mobile_number"
    t.decimal  "amount"
    t.decimal  "total"
    t.string   "bill_number"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "service_bills", ["bill_number"], name: "index_service_bills_on_bill_number", unique: true
  add_index "service_bills", ["user_id"], name: "index_service_bills_on_user_id"

  create_table "ticket_bills", force: true do |t|
    t.string   "customer_name"
    t.string   "service_name"
    t.string   "mobile_number"
    t.string   "ticket_number"
    t.decimal  "amount"
    t.decimal  "total"
    t.string   "bill_number"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ticket_bills", ["bill_number"], name: "index_ticket_bills_on_bill_number", unique: true
  add_index "ticket_bills", ["user_id"], name: "index_ticket_bills_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
