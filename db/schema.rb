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

ActiveRecord::Schema.define(version: 20170610103553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "question_id"
    t.bigint "form_id"
    t.bigint "user_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id"], name: "index_answers_on_form_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "form_templates", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_form_templates_on_user_id"
  end

  create_table "forms", force: :cascade do |t|
    t.bigint "form_template_id"
    t.bigint "user_id"
    t.date "form_date"
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_template_id"], name: "index_forms_on_form_template_id"
    t.index ["user_id"], name: "index_forms_on_user_id"
  end

  create_table "logs", force: :cascade do |t|
    t.bigint "form_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id"], name: "index_logs_on_form_id"
    t.index ["user_id"], name: "index_logs_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "form_template_id"
    t.integer "qns_type"
    t.string "label"
    t.string "options"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "required", default: true, null: false
    t.integer "qns_no", default: 0, null: false
    t.index ["form_template_id"], name: "index_questions_on_form_template_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.boolean "is_admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answers", "forms"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "form_templates", "users"
  add_foreign_key "forms", "form_templates"
  add_foreign_key "forms", "users"
  add_foreign_key "logs", "forms"
  add_foreign_key "logs", "users"
  add_foreign_key "questions", "form_templates"
end
