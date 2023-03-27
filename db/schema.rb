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

ActiveRecord::Schema[7.0].define(version: 2022_12_26_201400) do
  create_table "assignments", force: :cascade do |t|
    t.integer "store_id", null: false
    t.integer "employee_id", null: false
    t.integer "pay_grade_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.index ["employee_id"], name: "index_assignments_on_employee_id"
    t.index ["pay_grade_id"], name: "index_assignments_on_pay_grade_id"
    t.index ["store_id"], name: "index_assignments_on_store_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "ssn"
    t.date "date_of_birth"
    t.string "phone"
    t.integer "role"
    t.boolean "active", default: true
    t.string "username"
    t.string "password_digest"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "active", default: true
  end

  create_table "pay_grade_rates", force: :cascade do |t|
    t.integer "pay_grade_id", null: false
    t.float "rate"
    t.date "start_date"
    t.date "end_date"
    t.index ["pay_grade_id"], name: "index_pay_grade_rates_on_pay_grade_id"
  end

  create_table "pay_grades", force: :cascade do |t|
    t.string "level"
    t.boolean "active", default: true
  end

  create_table "shift_jobs", force: :cascade do |t|
    t.integer "shift_id", null: false
    t.integer "job_id", null: false
    t.index ["job_id"], name: "index_shift_jobs_on_job_id"
    t.index ["shift_id"], name: "index_shift_jobs_on_shift_id"
  end

  create_table "shifts", force: :cascade do |t|
    t.integer "assignment_id", null: false
    t.date "date"
    t.time "start_time"
    t.time "end_time"
    t.text "notes"
    t.integer "status"
    t.index ["assignment_id"], name: "index_shifts_on_assignment_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone"
    t.boolean "active", default: true
  end

  add_foreign_key "assignments", "employees"
  add_foreign_key "assignments", "pay_grades"
  add_foreign_key "assignments", "stores"
  add_foreign_key "pay_grade_rates", "pay_grades"
  add_foreign_key "shift_jobs", "jobs"
  add_foreign_key "shift_jobs", "shifts"
  add_foreign_key "shifts", "assignments"
end
