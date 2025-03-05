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

ActiveRecord::Schema[8.0].define(version: 2025_03_05_023559) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "post_id", null: false
    t.integer "parent_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "event_chats", force: :cascade do |t|
    t.integer "play_event_id", null: false
    t.integer "user_id", null: false
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["play_event_id"], name: "index_event_chats_on_play_event_id"
    t.index ["user_id"], name: "index_event_chats_on_user_id"
  end

  create_table "event_participants", force: :cascade do |t|
    t.integer "play_event_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["play_event_id"], name: "index_event_participants_on_play_event_id"
    t.index ["user_id"], name: "index_event_participants_on_user_id"
  end

  create_table "join_requests", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "play_event_id", null: false
    t.string "status", default: "pending"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["play_event_id"], name: "index_join_requests_on_play_event_id"
    t.index ["user_id", "play_event_id"], name: "index_join_requests_on_user_id_and_play_event_id", unique: true
    t.index ["user_id"], name: "index_join_requests_on_user_id"
  end

  create_table "play_events", force: :cascade do |t|
    t.bigint "sport_id"
    t.bigint "host_id"
    t.string "sport_type"
    t.string "event_location"
    t.string "event_category"
    t.text "event_instructions"
    t.datetime "event_start_time"
    t.datetime "event_end_time"
    t.integer "event_capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "processed", default: false
    t.index ["host_id"], name: "index_play_events_on_host_id"
    t.index ["sport_id"], name: "index_play_events_on_sport_id"
  end

  create_table "post_likes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_likes_on_post_id"
    t.index ["user_id"], name: "index_post_likes_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "description"
    t.string "media_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "sport_sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "sport_id", null: false
    t.integer "duration_minutes"
    t.date "played_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sport_id"], name: "index_sport_sessions_on_sport_id"
    t.index ["user_id"], name: "index_sport_sessions_on_user_id"
  end

  create_table "sports", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sports_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "sport_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sport_id"], name: "index_sports_users_on_sport_id"
    t.index ["user_id"], name: "index_sports_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "location"
    t.string "profile_picture"
    t.json "sports"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "event_chats", "play_events"
  add_foreign_key "event_chats", "users"
  add_foreign_key "event_participants", "play_events"
  add_foreign_key "event_participants", "users"
  add_foreign_key "join_requests", "play_events"
  add_foreign_key "join_requests", "users"
  add_foreign_key "play_events", "sports"
  add_foreign_key "play_events", "users", column: "host_id"
  add_foreign_key "post_likes", "posts"
  add_foreign_key "post_likes", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "sport_sessions", "sports"
  add_foreign_key "sport_sessions", "users"
  add_foreign_key "sports_users", "sports"
  add_foreign_key "sports_users", "users"
end
