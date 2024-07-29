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

ActiveRecord::Schema[7.1].define(version: 2024_07_29_104130) do
  create_table "appointments", force: :cascade do |t|
    t.integer "patient_id", null: false
    t.integer "doctor_id", null: false
    t.date "date"
    t.time "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id"
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "name"
    t.string "specialty"
    t.string "contact_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doctors_patients", id: false, force: :cascade do |t|
    t.integer "doctor_id", null: false
    t.integer "patient_id", null: false
  end

  create_table "medical_records", force: :cascade do |t|
    t.integer "patient_id", null: false
    t.integer "doctor_id", null: false
    t.text "diagnosis"
    t.text "prescription"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_medical_records_on_doctor_id"
    t.index ["patient_id"], name: "index_medical_records_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "contact_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date_of_birth"
  end

  add_foreign_key "appointments", "doctors"
  add_foreign_key "appointments", "patients"
  add_foreign_key "medical_records", "doctors"
  add_foreign_key "medical_records", "patients"
end
