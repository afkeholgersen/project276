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

ActiveRecord::Schema.define(version: 20161203225046) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text     "comment_text"
    t.integer  "vote",         default: 0
    t.integer  "user_id"
    t.integer  "recipe_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "dietlabels", force: :cascade do |t|
    t.string   "name"
    t.string   "apiparameter"
    t.string   "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "dietlabels_preferences", force: :cascade do |t|
    t.integer "preference_id"
    t.integer "dietlabel_id"
    t.index ["dietlabel_id"], name: "index_dietlabels_preferences_on_dietlabel_id", using: :btree
    t.index ["preference_id"], name: "index_dietlabels_preferences_on_preference_id", using: :btree
  end

  create_table "healthlabels", force: :cascade do |t|
    t.string   "name"
    t.string   "apiparameter"
    t.string   "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "healthlabels_preferences", force: :cascade do |t|
    t.integer "preference_id"
    t.integer "healthlabel_id"
    t.index ["healthlabel_id"], name: "index_healthlabels_preferences_on_healthlabel_id", using: :btree
    t.index ["preference_id"], name: "index_healthlabels_preferences_on_preference_id", using: :btree
  end

  create_table "preferences", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "dietLabels"
    t.text     "healthLabels"
    t.string   "source"
    t.string   "sourceIcon"
    t.string   "title"
  end

  create_table "recipes_savedrecipes", force: :cascade do |t|
    t.integer "savedrecipe_id"
    t.integer "recipe_id"
    t.index ["recipe_id"], name: "index_recipes_savedrecipes_on_recipe_id", using: :btree
    t.index ["savedrecipe_id"], name: "index_recipes_savedrecipes_on_savedrecipe_id", using: :btree
  end

  create_table "savedrecipes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password"
    t.string   "salt"
    t.integer  "role"
    t.integer  "preference_id"
    t.integer  "savedrecipe_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

end
