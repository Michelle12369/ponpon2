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

ActiveRecord::Schema.define(version: 20160904092932) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "trackable_type"
    t.integer  "trackable_id"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.string   "key"
    t.text     "parameters"
    t.string   "recipient_type"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree
  end

  create_table "admin_searches", force: :cascade do |t|
    t.string   "location"
    t.string   "gender"
    t.integer  "relation"
    t.integer  "max_age"
    t.integer  "min_age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
    t.index ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "coupon_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "coupon_anc_desc_idx", unique: true, using: :btree
    t.index ["descendant_id"], name: "coupon_desc_idx", using: :btree
  end

  create_table "coupons", force: :cascade do |t|
    t.date     "expiry_date"
    t.float    "discount"
    t.string   "coupon_title"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "user_id"
    t.integer  "parent_id"
    t.string   "item"
    t.date     "start_date"
    t.integer  "discount_type"
    t.integer  "discount_ceiling_people"
    t.float    "discount_ceiling_amount"
    t.text     "other_content"
    t.boolean  "used"
    t.float    "computed_discount"
    t.string   "qr_code"
    t.string   "coupon_pic"
    t.integer  "store_id"
    t.integer  "admin_coupon_limit"
  end

  create_table "follows", force: :cascade do |t|
    t.string   "followable_type",                 null: false
    t.integer  "followable_id",                   null: false
    t.string   "follower_type",                   null: false
    t.integer  "follower_id",                     null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["followable_id", "followable_type"], name: "fk_followables", using: :btree
    t.index ["follower_id", "follower_type"], name: "fk_follows", using: :btree
  end

  create_table "items", force: :cascade do |t|
    t.integer  "item_price"
    t.string   "item_name"
    t.text     "item_about"
    t.integer  "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "item_type"
    t.index ["store_id"], name: "index_items_on_store_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.string   "attachment"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "cached_votes_up", default: 0
    t.integer  "comments_count",  default: 0
    t.integer  "store_id"
    t.index ["cached_votes_up"], name: "index_posts_on_cached_votes_up", using: :btree
    t.index ["comments_count"], name: "index_posts_on_comments_count", using: :btree
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "store_users", force: :cascade do |t|
    t.integer  "store_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_store_users_on_store_id", using: :btree
    t.index ["user_id"], name: "index_store_users_on_user_id", using: :btree
  end

  create_table "stores", force: :cascade do |t|
    t.string   "store_phone"
    t.string   "store_address"
    t.string   "store_name"
    t.string   "store_keeper_name"
    t.string   "store_keeper_phone"
    t.string   "store_email"
    t.text     "store_about"
    t.string   "store_type"
    t.text     "store_time"
    t.text     "store_rule"
    t.json     "store_photo"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "store_status"
    t.string   "store_cover_photo"
    t.string   "store_city"
    t.integer  "fee_type"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "about"
    t.string   "avatar"
    t.string   "cover"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.integer  "role"
    t.string   "remote_avatar_url"
    t.string   "gender"
    t.date     "birthday"
    t.integer  "age"
    t.string   "location"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.string   "votable_type"
    t.integer  "votable_id"
    t.string   "voter_type"
    t.integer  "voter_id"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree
  end

  add_foreign_key "posts", "users"
end
