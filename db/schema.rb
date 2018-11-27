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

ActiveRecord::Schema.define(version: 20181126105844) do

  create_table "books", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "isbn"
    t.string   "title"
    t.string   "url"
    t.string   "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "price"
    t.string   "author"
    t.string   "caption"
  end

  create_table "my_conditions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "systemid_for_calil"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "systemname_for_calil"
    t.string   "prefecture_name"
    t.index ["user_id", "systemid_for_calil"], name: "index_my_conditions_on_user_id_and_systemid_for_calil", unique: true, using: :btree
    t.index ["user_id"], name: "index_my_conditions_on_user_id", using: :btree
  end

  create_table "ownerships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_ownerships_on_book_id", using: :btree
    t.index ["user_id", "book_id", "type"], name: "index_ownerships_on_user_id_and_book_id_and_type", unique: true, using: :btree
    t.index ["user_id"], name: "index_ownerships_on_user_id", using: :btree
  end

  create_table "reviews", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.integer  "rating"
    t.string   "review"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_reviews_on_book_id", using: :btree
    t.index ["user_id", "book_id"], name: "index_reviews_on_user_id_and_book_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "my_conditions", "users"
  add_foreign_key "ownerships", "books"
  add_foreign_key "ownerships", "users"
  add_foreign_key "reviews", "books"
  add_foreign_key "reviews", "users"
end
