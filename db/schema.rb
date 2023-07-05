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

ActiveRecord::Schema[7.0].define(version: 2023_07_05_013931) do
  create_table "active_storage_attachments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
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

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "candidates", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "event_hub_id", null: false
    t.bigint "elect_position_id", null: false
    t.bigint "coop_event_id"
    t.string "last_name"
    t.string "first_name"
    t.string "middle_name"
    t.string "suffix"
    t.date "birth_date"
    t.text "address"
    t.string "mobile_number"
    t.string "email"
    t.string "education"
    t.string "company"
    t.string "occupation"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coop_event_id"], name: "index_candidates_on_coop_event_id"
    t.index ["elect_position_id"], name: "index_candidates_on_elect_position_id"
    t.index ["event_hub_id"], name: "index_candidates_on_event_hub_id"
  end

  create_table "coop_events", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.date "event_date"
    t.text "description"
    t.boolean "election"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cooperatives", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "geo_region_id"
    t.bigint "geo_province_id"
    t.bigint "geo_municipality_id"
    t.bigint "geo_barangay_id"
    t.string "street"
    t.string "tin"
    t.string "registration_no"
    t.string "coop_type"
    t.string "email"
    t.string "contact_no"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["geo_barangay_id"], name: "index_cooperatives_on_geo_barangay_id"
    t.index ["geo_municipality_id"], name: "index_cooperatives_on_geo_municipality_id"
    t.index ["geo_province_id"], name: "index_cooperatives_on_geo_province_id"
    t.index ["geo_region_id"], name: "index_cooperatives_on_geo_region_id"
  end

  create_table "elect_positions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "coop_event_id", null: false
    t.string "name"
    t.integer "vacant"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coop_event_id"], name: "index_elect_positions_on_coop_event_id"
  end

  create_table "elections", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "event_hub_id"
    t.bigint "coop_event_id"
    t.string "voter_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coop_event_id"], name: "index_elections_on_coop_event_id"
    t.index ["event_hub_id"], name: "index_elections_on_event_hub_id"
  end

  create_table "event_hubs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "coop_event_id", null: false
    t.bigint "cooperative_id", null: false
    t.decimal "capital", precision: 18, scale: 2
    t.decimal "vote_power", precision: 18, scale: 2
    t.string "vote_code"
    t.boolean "voted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.index ["coop_event_id"], name: "index_event_hubs_on_coop_event_id"
    t.index ["cooperative_id"], name: "index_event_hubs_on_cooperative_id"
  end

  create_table "geo_barangays", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "geo_region_id", null: false
    t.bigint "geo_province_id", null: false
    t.bigint "geo_municipality_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["geo_municipality_id"], name: "index_geo_barangays_on_geo_municipality_id"
    t.index ["geo_province_id"], name: "index_geo_barangays_on_geo_province_id"
    t.index ["geo_region_id"], name: "index_geo_barangays_on_geo_region_id"
  end

  create_table "geo_municipalities", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "geo_region_id", null: false
    t.bigint "geo_province_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["geo_province_id"], name: "index_geo_municipalities_on_geo_province_id"
    t.index ["geo_region_id"], name: "index_geo_municipalities_on_geo_region_id"
  end

  create_table "geo_provinces", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "geo_region_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["geo_region_id"], name: "index_geo_provinces_on_geo_region_id"
  end

  create_table "geo_regions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participants", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "event_hub_id", null: false
    t.string "last_name"
    t.string "first_name"
    t.string "middle_name"
    t.date "birth_date"
    t.string "mobile_number"
    t.string "email"
    t.string "guest_type"
    t.string "attendance_channel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_hub_id"], name: "index_participants_on_event_hub_id"
  end

  create_table "registrations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "event_hub_id"
    t.string "last_name"
    t.string "first_name"
    t.string "middle_name"
    t.date "birth_date"
    t.string "mobile_number"
    t.string "email"
    t.string "guest_type"
    t.string "attendance"
    t.boolean "attend"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "attend_date"
    t.decimal "price", precision: 8, scale: 2
    t.boolean "paid"
    t.boolean "award"
    t.string "size"
    t.boolean "tentative"
    t.string "dietary"
    t.string "gender"
    t.index ["event_hub_id"], name: "index_registrations_on_event_hub_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.string "middle_name"
    t.boolean "enable"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "event_hub_id", null: false
    t.bigint "coop_event_id", null: false
    t.bigint "candidate_id", null: false
    t.bigint "elect_position_id"
    t.decimal "vote_amount", precision: 10, scale: 2
    t.boolean "post"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_votes_on_candidate_id"
    t.index ["coop_event_id"], name: "index_votes_on_coop_event_id"
    t.index ["elect_position_id"], name: "index_votes_on_elect_position_id"
    t.index ["event_hub_id"], name: "index_votes_on_event_hub_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "candidates", "elect_positions"
  add_foreign_key "candidates", "event_hubs"
  add_foreign_key "elect_positions", "coop_events"
  add_foreign_key "event_hubs", "coop_events"
  add_foreign_key "event_hubs", "cooperatives"
  add_foreign_key "geo_barangays", "geo_municipalities"
  add_foreign_key "geo_barangays", "geo_provinces"
  add_foreign_key "geo_barangays", "geo_regions"
  add_foreign_key "geo_municipalities", "geo_provinces"
  add_foreign_key "geo_municipalities", "geo_regions"
  add_foreign_key "geo_provinces", "geo_regions"
  add_foreign_key "participants", "event_hubs"
  add_foreign_key "votes", "candidates"
  add_foreign_key "votes", "coop_events"
  add_foreign_key "votes", "event_hubs"
end
