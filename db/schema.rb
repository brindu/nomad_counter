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

ActiveRecord::Schema[7.0].define(version: 2022_03_06_144302) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "slack_posts", force: :cascade do |t|
    t.string "external_id"
    t.string "team_id"
    t.string "user_id"
    t.string "channel_id"
    t.datetime "timestamp"
    t.text "text"
    t.boolean "exposed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "team_id"
    t.string "name"
    t.string "domain"
    t.string "token"
    t.string "oauth_scope"
    t.string "oauth_version", default: "v1", null: false
    t.string "bot_user_id"
    t.string "activated_user_id"
    t.string "activated_user_access_token"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
