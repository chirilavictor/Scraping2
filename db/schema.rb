# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150205131336) do

  create_table "davinci_carnes", force: true do |t|
    t.string   "fel_mancare"
    t.integer  "pret"
    t.string   "descriere"
    t.string   "cantitate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "davinci_deserts", force: true do |t|
    t.string   "fel_mancare"
    t.integer  "pret"
    t.string   "descriere"
    t.string   "cantitate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "davinci_pastes", force: true do |t|
    t.string   "fel_mancare"
    t.integer  "pret"
    t.string   "descriere"
    t.string   "cantitate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "davinci_pestes", force: true do |t|
    t.string   "fel_mancare"
    t.integer  "pret"
    t.string   "descriere"
    t.string   "cantitate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "davinci_salates", force: true do |t|
    t.string   "fel_mancare"
    t.integer  "pret"
    t.string   "descriere"
    t.string   "cantitate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rest_horas", force: true do |t|
    t.string   "categorie"
    t.string   "fel_mancare"
    t.string   "cantitate"
    t.string   "pret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
