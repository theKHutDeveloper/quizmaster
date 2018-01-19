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

ActiveRecord::Schema.define(version: 20180119124141) do

  create_table "questions", force: :cascade do |t|
    t.integer "subject_id"
    t.text "question", null: false
    t.string "choice1", null: false
    t.string "choice2"
    t.string "choice3"
    t.string "answer", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_questions_on_subject_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "subject_id"
    t.text "answered_question"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "score"
    t.index ["subject_id"], name: "index_quizzes_on_subject_id"
    t.index ["user_id"], name: "index_quizzes_on_user_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "subject"
    t.integer "difficulty"
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "subscriber"
  end

end
