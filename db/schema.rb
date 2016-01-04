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

ActiveRecord::Schema.define(version: 20160104061057) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accomplishments", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.text     "accomplishment"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "accomplishments", ["owner_id"], name: "index_accomplishments_on_owner_id", using: :btree

  create_table "acne_measurement_pictures", force: :cascade do |t|
    t.integer  "acne_measurement_id"
    t.integer  "identity_file_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "acne_measurement_pictures", ["acne_measurement_id"], name: "index_acne_measurement_pictures_on_acne_measurement_id", using: :btree
  add_index "acne_measurement_pictures", ["identity_file_id"], name: "index_acne_measurement_pictures_on_identity_file_id", using: :btree
  add_index "acne_measurement_pictures", ["owner_id"], name: "index_acne_measurement_pictures_on_owner_id", using: :btree

  create_table "acne_measurements", force: :cascade do |t|
    t.datetime "measurement_datetime"
    t.string   "acne_location",        limit: 255
    t.integer  "total_pimples"
    t.integer  "new_pimples"
    t.integer  "worrying_pimples"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "acne_measurements", ["owner_id"], name: "index_acne_measurements_on_owner_id", using: :btree

  create_table "activities", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "activities", ["owner_id"], name: "index_activities_on_owner_id", using: :btree

  create_table "apartment_leases", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "apartment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "monthly_rent", precision: 10, scale: 2
    t.decimal  "moveout_fee",  precision: 10, scale: 2
    t.decimal  "deposit",      precision: 10, scale: 2
    t.date     "terminate_by"
    t.integer  "owner_id"
  end

  add_index "apartment_leases", ["apartment_id"], name: "index_apartment_leases_on_apartment_id", using: :btree
  add_index "apartment_leases", ["owner_id"], name: "index_apartment_leases_on_owner_id", using: :btree

  create_table "apartment_pictures", force: :cascade do |t|
    t.integer  "apartment_id"
    t.integer  "identity_file_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apartment_pictures", ["apartment_id"], name: "index_apartment_pictures_on_apartment_id", using: :btree
  add_index "apartment_pictures", ["identity_file_id"], name: "index_apartment_pictures_on_identity_file_id", using: :btree
  add_index "apartment_pictures", ["owner_id"], name: "index_apartment_pictures_on_owner_id", using: :btree

  create_table "apartment_trash_pickups", force: :cascade do |t|
    t.integer  "trash_type"
    t.text     "notes"
    t.integer  "apartment_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "repeat_id"
  end

  add_index "apartment_trash_pickups", ["apartment_id"], name: "index_apartment_trash_pickups_on_apartment_id", using: :btree
  add_index "apartment_trash_pickups", ["owner_id"], name: "index_apartment_trash_pickups_on_owner_id", using: :btree
  add_index "apartment_trash_pickups", ["repeat_id"], name: "index_apartment_trash_pickups_on_repeat_id", using: :btree

  create_table "apartments", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "landlord_id"
    t.text     "notes"
    t.integer  "visit_count"
  end

  add_index "apartments", ["landlord_id"], name: "index_apartments_on_landlord_id", using: :btree
  add_index "apartments", ["location_id"], name: "index_apartments_on_location_id", using: :btree
  add_index "apartments", ["owner_id"], name: "index_apartments_on_owner_id", using: :btree

  create_table "bank_accounts", force: :cascade do |t|
    t.string   "name",                        limit: 255
    t.string   "account_number",              limit: 255
    t.integer  "account_number_encrypted_id"
    t.string   "routing_number",              limit: 255
    t.integer  "routing_number_encrypted_id"
    t.string   "pin",                         limit: 255
    t.integer  "pin_encrypted_id"
    t.integer  "password_id"
    t.integer  "company_id"
    t.integer  "home_address_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "defunct"
    t.integer  "visit_count"
  end

  add_index "bank_accounts", ["account_number_encrypted_id"], name: "index_bank_accounts_on_account_number_encrypted_id", using: :btree
  add_index "bank_accounts", ["company_id"], name: "index_bank_accounts_on_company_id", using: :btree
  add_index "bank_accounts", ["home_address_id"], name: "index_bank_accounts_on_home_address_id", using: :btree
  add_index "bank_accounts", ["owner_id"], name: "index_bank_accounts_on_owner_id", using: :btree
  add_index "bank_accounts", ["password_id"], name: "index_bank_accounts_on_password_id", using: :btree
  add_index "bank_accounts", ["pin_encrypted_id"], name: "index_bank_accounts_on_pin_encrypted_id", using: :btree
  add_index "bank_accounts", ["routing_number_encrypted_id"], name: "index_bank_accounts_on_routing_number_encrypted_id", using: :btree

  create_table "bar_pictures", force: :cascade do |t|
    t.integer  "bar_id"
    t.integer  "identity_file_id"
    t.integer  "owner_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "bar_pictures", ["bar_id"], name: "index_bar_pictures_on_bar_id", using: :btree
  add_index "bar_pictures", ["identity_file_id"], name: "index_bar_pictures_on_identity_file_id", using: :btree
  add_index "bar_pictures", ["owner_id"], name: "index_bar_pictures_on_owner_id", using: :btree

  create_table "bars", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "rating"
    t.text     "notes"
    t.integer  "visit_count"
    t.integer  "owner_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "bars", ["location_id"], name: "index_bars_on_location_id", using: :btree
  add_index "bars", ["owner_id"], name: "index_bars_on_owner_id", using: :btree

  create_table "blood_concentrations", force: :cascade do |t|
    t.string   "concentration_name",    limit: 255
    t.integer  "concentration_type"
    t.decimal  "concentration_minimum",             precision: 10, scale: 2
    t.decimal  "concentration_maximum",             precision: 10, scale: 2
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "blood_concentrations", ["owner_id"], name: "index_blood_concentrations_on_owner_id", using: :btree

  create_table "blood_pressures", force: :cascade do |t|
    t.integer  "systolic_pressure"
    t.integer  "diastolic_pressure"
    t.date     "measurement_date"
    t.string   "measurement_source", limit: 255
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "blood_pressures", ["owner_id"], name: "index_blood_pressures_on_owner_id", using: :btree

  create_table "blood_test_results", force: :cascade do |t|
    t.integer  "blood_test_id"
    t.integer  "blood_concentration_id"
    t.decimal  "concentration",          precision: 10, scale: 2
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blood_test_results", ["blood_concentration_id"], name: "index_blood_test_results_on_blood_concentration_id", using: :btree
  add_index "blood_test_results", ["blood_test_id"], name: "index_blood_test_results_on_blood_test_id", using: :btree
  add_index "blood_test_results", ["owner_id"], name: "index_blood_test_results_on_owner_id", using: :btree

  create_table "blood_tests", force: :cascade do |t|
    t.datetime "fast_started"
    t.datetime "test_time"
    t.text     "notes"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "blood_tests", ["owner_id"], name: "index_blood_tests_on_owner_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "book_name",      limit: 255
    t.string   "isbn",           limit: 255
    t.string   "author",         limit: 255
    t.datetime "when_read"
    t.integer  "owner_id"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.integer  "recommender_id"
  end

  add_index "books", ["owner_id"], name: "index_books_on_owner_id", using: :btree
  add_index "books", ["recommender_id"], name: "index_books_on_recommender_id", using: :btree

  create_table "calculation_elements", force: :cascade do |t|
    t.integer  "left_operand_id"
    t.integer  "right_operand_id"
    t.integer  "operator"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
  end

  add_index "calculation_elements", ["left_operand_id"], name: "index_calculation_elements_on_left_operand_id", using: :btree
  add_index "calculation_elements", ["owner_id"], name: "index_calculation_elements_on_owner_id", using: :btree
  add_index "calculation_elements", ["right_operand_id"], name: "index_calculation_elements_on_right_operand_id", using: :btree

  create_table "calculation_forms", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "root_element_id"
    t.text     "equation"
    t.boolean  "is_duplicate"
    t.integer  "visit_count"
  end

  add_index "calculation_forms", ["owner_id"], name: "index_calculation_forms_on_owner_id", using: :btree
  add_index "calculation_forms", ["root_element_id"], name: "index_calculation_forms_on_root_element_id", using: :btree

  create_table "calculation_inputs", force: :cascade do |t|
    t.string   "input_name",          limit: 255
    t.string   "input_value",         limit: 255
    t.integer  "calculation_form_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "variable_name",       limit: 255
    t.integer  "owner_id"
  end

  add_index "calculation_inputs", ["calculation_form_id"], name: "index_calculation_inputs_on_calculation_form_id", using: :btree
  add_index "calculation_inputs", ["owner_id"], name: "index_calculation_inputs_on_owner_id", using: :btree

  create_table "calculation_operands", force: :cascade do |t|
    t.string   "constant_value",         limit: 255
    t.integer  "calculation_element_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "calculation_input_id"
    t.integer  "owner_id"
  end

  add_index "calculation_operands", ["calculation_element_id"], name: "index_calculation_operands_on_calculation_element_id", using: :btree
  add_index "calculation_operands", ["owner_id"], name: "index_calculation_operands_on_owner_id", using: :btree

  create_table "calculations", force: :cascade do |t|
    t.string   "name",                         limit: 255
    t.integer  "calculation_form_id"
    t.decimal  "result",                                   precision: 10, scale: 2
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "original_calculation_form_id"
    t.integer  "visit_count"
  end

  add_index "calculations", ["calculation_form_id"], name: "index_calculations_on_calculation_form_id", using: :btree
  add_index "calculations", ["owner_id"], name: "index_calculations_on_owner_id", using: :btree

  create_table "camp_locations", force: :cascade do |t|
    t.integer  "location_id"
    t.boolean  "vehicle_parking"
    t.boolean  "free"
    t.boolean  "sewage"
    t.boolean  "fresh_water"
    t.boolean  "electricity"
    t.boolean  "internet"
    t.boolean  "trash"
    t.boolean  "shower"
    t.boolean  "bathroom"
    t.integer  "noise_level"
    t.integer  "rating"
    t.boolean  "overnight_allowed"
    t.text     "notes"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.boolean  "boondocking"
    t.boolean  "cell_phone_reception"
    t.boolean  "cell_phone_data"
    t.integer  "membership_id"
  end

  add_index "camp_locations", ["location_id"], name: "index_camp_locations_on_location_id", using: :btree
  add_index "camp_locations", ["membership_id"], name: "index_camp_locations_on_membership_id", using: :btree
  add_index "camp_locations", ["owner_id"], name: "index_camp_locations_on_owner_id", using: :btree

  create_table "cashbacks", force: :cascade do |t|
    t.integer  "owner_id"
    t.decimal  "cashback_percentage",             precision: 10, scale: 2
    t.string   "applies_to",          limit: 255
    t.date     "start_date"
    t.date     "end_date"
    t.decimal  "yearly_maximum",                  precision: 10, scale: 2
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "default_cashback"
  end

  add_index "cashbacks", ["owner_id"], name: "index_cashbacks_on_owner_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.string   "link",                  limit: 255
    t.integer  "position"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "additional_filtertext", limit: 255
    t.string   "icon",                  limit: 255
    t.boolean  "explicit"
    t.integer  "user_type_mask"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree
  add_index "categories", ["parent_id"], name: "index_categories_on_parent_id", using: :btree

  create_table "category_points_amounts", force: :cascade do |t|
    t.integer  "owner_id"
    t.integer  "category_id"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visits"
    t.datetime "last_visit"
  end

  add_index "category_points_amounts", ["category_id"], name: "index_category_points_amounts_on_category_id", using: :btree
  add_index "category_points_amounts", ["owner_id"], name: "index_category_points_amounts_on_owner_id", using: :btree

  create_table "checklist_items", force: :cascade do |t|
    t.string   "checklist_item_name", limit: 255
    t.integer  "checklist_id"
    t.integer  "position"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checklist_items", ["checklist_id"], name: "index_checklist_items_on_checklist_id", using: :btree
  add_index "checklist_items", ["owner_id"], name: "index_checklist_items_on_owner_id", using: :btree

  create_table "checklist_references", force: :cascade do |t|
    t.integer  "checklist_parent_id"
    t.integer  "checklist_id"
    t.integer  "owner_id"
    t.boolean  "pre_checklist"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checklist_references", ["checklist_id"], name: "index_checklist_references_on_checklist_id", using: :btree
  add_index "checklist_references", ["checklist_parent_id"], name: "index_checklist_references_on_checklist_parent_id", using: :btree
  add_index "checklist_references", ["owner_id"], name: "index_checklist_references_on_owner_id", using: :btree

  create_table "checklists", force: :cascade do |t|
    t.string   "checklist_name", limit: 255
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "checklists", ["owner_id"], name: "index_checklists_on_owner_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.integer  "owner_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",        limit: 255
    t.text     "notes"
    t.integer  "visit_count"
  end

  add_index "companies", ["location_id"], name: "index_companies_on_location_id", using: :btree
  add_index "companies", ["owner_id"], name: "index_companies_on_owner_id", using: :btree

  create_table "complete_due_items", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "display",                      limit: 255
    t.string   "link",                         limit: 255
    t.datetime "due_date"
    t.string   "myp_model_name",               limit: 255
    t.integer  "model_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "original_due_date"
    t.integer  "myplaceonline_due_display_id"
  end

  add_index "complete_due_items", ["myplaceonline_due_display_id"], name: "index_complete_due_items_on_myplaceonline_due_display_id", using: :btree
  add_index "complete_due_items", ["owner_id"], name: "index_complete_due_items_on_owner_id", using: :btree

  create_table "computers", force: :cascade do |t|
    t.date     "purchased"
    t.decimal  "price",                             precision: 10, scale: 2
    t.string   "computer_model",        limit: 255
    t.string   "serial_number",         limit: 255
    t.integer  "manufacturer_id"
    t.integer  "max_resolution_width"
    t.integer  "max_resolution_height"
    t.integer  "ram"
    t.integer  "num_cpus"
    t.integer  "num_cores_per_cpu"
    t.boolean  "hyperthreaded"
    t.decimal  "max_cpu_speed",                     precision: 10, scale: 2
    t.text     "notes"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "administrator_id"
    t.integer  "main_user_id"
    t.integer  "dimensions_type"
    t.decimal  "width",                             precision: 10, scale: 2
    t.decimal  "height",                            precision: 10, scale: 2
    t.decimal  "depth",                             precision: 10, scale: 2
    t.integer  "weight_type"
    t.decimal  "weight",                            precision: 10, scale: 2
    t.integer  "visit_count"
  end

  add_index "computers", ["administrator_id"], name: "index_computers_on_administrator_id", using: :btree
  add_index "computers", ["main_user_id"], name: "index_computers_on_main_user_id", using: :btree
  add_index "computers", ["manufacturer_id"], name: "index_computers_on_manufacturer_id", using: :btree
  add_index "computers", ["owner_id"], name: "index_computers_on_owner_id", using: :btree

  create_table "concert_musical_groups", force: :cascade do |t|
    t.integer  "owner_id"
    t.integer  "concert_id"
    t.integer  "musical_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "concert_musical_groups", ["concert_id"], name: "index_concert_musical_groups_on_concert_id", using: :btree
  add_index "concert_musical_groups", ["musical_group_id"], name: "index_concert_musical_groups_on_musical_group_id", using: :btree
  add_index "concert_musical_groups", ["owner_id"], name: "index_concert_musical_groups_on_owner_id", using: :btree

  create_table "concert_pictures", force: :cascade do |t|
    t.integer  "concert_id"
    t.integer  "identity_file_id"
    t.integer  "owner_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "concert_pictures", ["concert_id"], name: "index_concert_pictures_on_concert_id", using: :btree
  add_index "concert_pictures", ["identity_file_id"], name: "index_concert_pictures_on_identity_file_id", using: :btree
  add_index "concert_pictures", ["owner_id"], name: "index_concert_pictures_on_owner_id", using: :btree

  create_table "concerts", force: :cascade do |t|
    t.string   "concert_date",  limit: 255
    t.string   "concert_title", limit: 255
    t.integer  "location_id"
    t.text     "notes"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "concerts", ["location_id"], name: "index_concerts_on_location_id", using: :btree
  add_index "concerts", ["owner_id"], name: "index_concerts_on_owner_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.integer  "contact_identity_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contact_type"
    t.integer  "visit_count"
  end

  add_index "contacts", ["contact_identity_id"], name: "index_contacts_on_contact_identity_id", using: :btree
  add_index "contacts", ["owner_id"], name: "index_contacts_on_owner_id", using: :btree

  create_table "conversations", force: :cascade do |t|
    t.integer  "contact_id"
    t.text     "conversation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "conversation_date"
    t.integer  "owner_id"
  end

  add_index "conversations", ["contact_id"], name: "index_conversations_on_contact_id", using: :btree
  add_index "conversations", ["owner_id"], name: "index_conversations_on_owner_id", using: :btree

  create_table "credit_card_cashbacks", force: :cascade do |t|
    t.integer  "owner_id"
    t.integer  "credit_card_id"
    t.integer  "cashback_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "credit_card_cashbacks", ["cashback_id"], name: "index_credit_card_cashbacks_on_cashback_id", using: :btree
  add_index "credit_card_cashbacks", ["credit_card_id"], name: "index_credit_card_cashbacks_on_credit_card_id", using: :btree
  add_index "credit_card_cashbacks", ["owner_id"], name: "index_credit_card_cashbacks_on_owner_id", using: :btree

  create_table "credit_cards", force: :cascade do |t|
    t.string   "name",                       limit: 255
    t.string   "number",                     limit: 255
    t.date     "expires"
    t.string   "security_code",              limit: 255
    t.integer  "password_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pin",                        limit: 255
    t.text     "notes"
    t.integer  "address_id"
    t.integer  "number_encrypted_id"
    t.integer  "security_code_encrypted_id"
    t.integer  "pin_encrypted_id"
    t.integer  "expires_encrypted_id"
    t.datetime "defunct"
    t.integer  "card_type"
    t.decimal  "total_credit",                           precision: 10, scale: 2
    t.integer  "visit_count"
    t.boolean  "email_reminders"
  end

  add_index "credit_cards", ["address_id"], name: "index_credit_cards_on_address_id", using: :btree
  add_index "credit_cards", ["expires_encrypted_id"], name: "index_credit_cards_on_expires_encrypted_id", using: :btree
  add_index "credit_cards", ["number_encrypted_id"], name: "index_credit_cards_on_number_encrypted_id", using: :btree
  add_index "credit_cards", ["owner_id"], name: "index_credit_cards_on_owner_id", using: :btree
  add_index "credit_cards", ["password_id"], name: "index_credit_cards_on_password_id", using: :btree
  add_index "credit_cards", ["pin_encrypted_id"], name: "index_credit_cards_on_pin_encrypted_id", using: :btree
  add_index "credit_cards", ["security_code_encrypted_id"], name: "index_credit_cards_on_security_code_encrypted_id", using: :btree

  create_table "credit_scores", force: :cascade do |t|
    t.date     "score_date"
    t.integer  "score"
    t.string   "source",      limit: 255
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "credit_scores", ["owner_id"], name: "index_credit_scores_on_owner_id", using: :btree

  create_table "date_locations", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "visit_count"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "date_locations", ["location_id"], name: "index_date_locations_on_location_id", using: :btree
  add_index "date_locations", ["owner_id"], name: "index_date_locations_on_owner_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "dental_insurances", force: :cascade do |t|
    t.string   "insurance_name",       limit: 255
    t.integer  "insurance_company_id"
    t.boolean  "defunct"
    t.integer  "periodic_payment_id"
    t.text     "notes"
    t.integer  "group_company_id"
    t.integer  "password_id"
    t.string   "account_number",       limit: 255
    t.string   "group_number",         limit: 255
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "doctor_id"
    t.integer  "visit_count"
  end

  add_index "dental_insurances", ["doctor_id"], name: "index_dental_insurances_on_doctor_id", using: :btree
  add_index "dental_insurances", ["group_company_id"], name: "index_dental_insurances_on_group_company_id", using: :btree
  add_index "dental_insurances", ["insurance_company_id"], name: "index_dental_insurances_on_insurance_company_id", using: :btree
  add_index "dental_insurances", ["owner_id"], name: "index_dental_insurances_on_owner_id", using: :btree
  add_index "dental_insurances", ["password_id"], name: "index_dental_insurances_on_password_id", using: :btree
  add_index "dental_insurances", ["periodic_payment_id"], name: "index_dental_insurances_on_periodic_payment_id", using: :btree

  create_table "dentist_visits", force: :cascade do |t|
    t.date     "visit_date"
    t.integer  "cavities"
    t.text     "notes"
    t.integer  "dentist_id"
    t.integer  "dental_insurance_id"
    t.decimal  "paid",                precision: 10, scale: 2
    t.boolean  "cleaning"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "dentist_visits", ["dental_insurance_id"], name: "index_dentist_visits_on_dental_insurance_id", using: :btree
  add_index "dentist_visits", ["dentist_id"], name: "index_dentist_visits_on_dentist_id", using: :btree
  add_index "dentist_visits", ["owner_id"], name: "index_dentist_visits_on_owner_id", using: :btree

  create_table "desired_products", force: :cascade do |t|
    t.string   "product_name", limit: 255
    t.text     "notes"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "desired_products", ["owner_id"], name: "index_desired_products_on_owner_id", using: :btree

  create_table "diary_entries", force: :cascade do |t|
    t.datetime "diary_time"
    t.text     "entry"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "diary_title", limit: 255
    t.integer  "visit_count"
  end

  add_index "diary_entries", ["owner_id"], name: "index_diary_entries_on_owner_id", using: :btree

  create_table "doctor_visits", force: :cascade do |t|
    t.date     "visit_date"
    t.text     "notes"
    t.integer  "doctor_id"
    t.integer  "health_insurance_id"
    t.decimal  "paid",                precision: 10, scale: 2
    t.boolean  "physical"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "doctor_visits", ["doctor_id"], name: "index_doctor_visits_on_doctor_id", using: :btree
  add_index "doctor_visits", ["health_insurance_id"], name: "index_doctor_visits_on_health_insurance_id", using: :btree
  add_index "doctor_visits", ["owner_id"], name: "index_doctor_visits_on_owner_id", using: :btree

  create_table "doctors", force: :cascade do |t|
    t.integer  "contact_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "doctor_type"
    t.integer  "visit_count"
  end

  add_index "doctors", ["contact_id"], name: "index_doctors_on_contact_id", using: :btree
  add_index "doctors", ["owner_id"], name: "index_doctors_on_owner_id", using: :btree

  create_table "drinks", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "drink_name",  limit: 255
    t.text     "notes"
    t.decimal  "calories",                precision: 10, scale: 2
    t.decimal  "price",                   precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "drinks", ["owner_id"], name: "index_drinks_on_owner_id", using: :btree

  create_table "due_items", force: :cascade do |t|
    t.string   "display",                      limit: 255
    t.string   "link",                         limit: 255
    t.datetime "due_date"
    t.string   "myp_model_name",               limit: 255
    t.integer  "model_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "original_due_date"
    t.boolean  "is_date_arbitrary"
    t.integer  "myplaceonline_due_display_id"
  end

  add_index "due_items", ["myplaceonline_due_display_id"], name: "index_due_items_on_myplaceonline_due_display_id", using: :btree
  add_index "due_items", ["owner_id"], name: "index_due_items_on_owner_id", using: :btree

  create_table "encrypted_values", force: :cascade do |t|
    t.binary   "val"
    t.binary   "salt"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "encryption_type"
  end

  add_index "encrypted_values", ["user_id"], name: "index_encrypted_values_on_user_id", using: :btree

  create_table "event_pictures", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "identity_file_id"
    t.integer  "owner_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "event_pictures", ["event_id"], name: "index_event_pictures_on_event_id", using: :btree
  add_index "event_pictures", ["identity_file_id"], name: "index_event_pictures_on_identity_file_id", using: :btree
  add_index "event_pictures", ["owner_id"], name: "index_event_pictures_on_owner_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "event_name",     limit: 255
    t.text     "notes"
    t.datetime "event_time"
    t.integer  "visit_count"
    t.integer  "owner_id"
    t.integer  "repeat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "event_end_time"
    t.integer  "location_id"
  end

  add_index "events", ["location_id"], name: "index_events_on_location_id", using: :btree
  add_index "events", ["owner_id"], name: "index_events_on_owner_id", using: :btree
  add_index "events", ["repeat_id"], name: "index_events_on_repeat_id", using: :btree

  create_table "exercises", force: :cascade do |t|
    t.datetime "exercise_start"
    t.datetime "exercise_end"
    t.string   "exercise_activity", limit: 255
    t.text     "notes"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "situps"
    t.integer  "pushups"
    t.integer  "cardio_time"
    t.integer  "visit_count"
  end

  add_index "exercises", ["owner_id"], name: "index_exercises_on_owner_id", using: :btree

  create_table "favorite_product_links", force: :cascade do |t|
    t.integer  "favorite_product_id"
    t.integer  "owner_id"
    t.string   "link",                limit: 2000
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "favorite_product_links", ["favorite_product_id"], name: "index_favorite_product_links_on_favorite_product_id", using: :btree
  add_index "favorite_product_links", ["owner_id"], name: "index_favorite_product_links_on_owner_id", using: :btree

  create_table "favorite_products", force: :cascade do |t|
    t.string   "product_name", limit: 255
    t.text     "notes"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "favorite_products", ["owner_id"], name: "index_favorite_products_on_owner_id", using: :btree

  create_table "feeds", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "url",         limit: 255
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "feeds", ["owner_id"], name: "index_feeds_on_owner_id", using: :btree

  create_table "files", force: :cascade do |t|
    t.integer "identity_file_id"
    t.string  "style",            limit: 255
    t.binary  "file_contents"
    t.integer "visit_count"
  end

  create_table "food_ingredients", force: :cascade do |t|
    t.integer  "owner_id"
    t.integer  "parent_food_id"
    t.integer  "food_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "food_ingredients", ["food_id"], name: "index_food_ingredients_on_food_id", using: :btree
  add_index "food_ingredients", ["owner_id"], name: "index_food_ingredients_on_owner_id", using: :btree
  add_index "food_ingredients", ["parent_food_id"], name: "index_food_ingredients_on_parent_food_id", using: :btree

  create_table "foods", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "food_name",   limit: 255
    t.text     "notes"
    t.decimal  "calories",                precision: 10, scale: 2
    t.decimal  "price",                   precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "weight_type"
    t.decimal  "weight",                  precision: 10, scale: 2
    t.integer  "visit_count"
  end

  add_index "foods", ["owner_id"], name: "index_foods_on_owner_id", using: :btree

  create_table "gas_stations", force: :cascade do |t|
    t.integer  "location_id"
    t.boolean  "gas"
    t.boolean  "diesel"
    t.boolean  "propane_replacement"
    t.boolean  "propane_fillup"
    t.integer  "visit_count"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gas_stations", ["location_id"], name: "index_gas_stations_on_location_id", using: :btree
  add_index "gas_stations", ["owner_id"], name: "index_gas_stations_on_owner_id", using: :btree

  create_table "group_contacts", force: :cascade do |t|
    t.integer  "owner_id"
    t.integer  "group_id"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_contacts", ["contact_id"], name: "index_group_contacts_on_contact_id", using: :btree
  add_index "group_contacts", ["group_id"], name: "index_group_contacts_on_group_id", using: :btree
  add_index "group_contacts", ["owner_id"], name: "index_group_contacts_on_owner_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "group_name",  limit: 255
    t.text     "notes"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "groups", ["owner_id"], name: "index_groups_on_owner_id", using: :btree

  create_table "gun_registrations", force: :cascade do |t|
    t.integer  "location_id"
    t.date     "registered"
    t.date     "expires"
    t.integer  "gun_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gun_registrations", ["gun_id"], name: "index_gun_registrations_on_gun_id", using: :btree
  add_index "gun_registrations", ["location_id"], name: "index_gun_registrations_on_location_id", using: :btree
  add_index "gun_registrations", ["owner_id"], name: "index_gun_registrations_on_owner_id", using: :btree

  create_table "guns", force: :cascade do |t|
    t.string   "gun_name",          limit: 255
    t.string   "manufacturer_name", limit: 255
    t.string   "gun_model",         limit: 255
    t.decimal  "bullet_caliber",                precision: 10, scale: 2
    t.integer  "max_bullets"
    t.decimal  "price",                         precision: 10, scale: 2
    t.date     "purchased"
    t.text     "notes"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "guns", ["owner_id"], name: "index_guns_on_owner_id", using: :btree

  create_table "headaches", force: :cascade do |t|
    t.datetime "started"
    t.datetime "ended"
    t.integer  "intensity"
    t.string   "headache_location", limit: 255
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "headaches", ["owner_id"], name: "index_headaches_on_owner_id", using: :btree

  create_table "health_insurances", force: :cascade do |t|
    t.string   "insurance_name",       limit: 255
    t.integer  "insurance_company_id"
    t.datetime "defunct"
    t.integer  "periodic_payment_id"
    t.text     "notes"
    t.integer  "group_company_id"
    t.integer  "password_id"
    t.string   "account_number",       limit: 255
    t.string   "group_number",         limit: 255
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "doctor_id"
    t.integer  "visit_count"
  end

  add_index "health_insurances", ["doctor_id"], name: "index_health_insurances_on_doctor_id", using: :btree
  add_index "health_insurances", ["group_company_id"], name: "index_health_insurances_on_group_company_id", using: :btree
  add_index "health_insurances", ["insurance_company_id"], name: "index_health_insurances_on_insurance_company_id", using: :btree
  add_index "health_insurances", ["owner_id"], name: "index_health_insurances_on_owner_id", using: :btree
  add_index "health_insurances", ["password_id"], name: "index_health_insurances_on_password_id", using: :btree
  add_index "health_insurances", ["periodic_payment_id"], name: "index_health_insurances_on_periodic_payment_id", using: :btree

  create_table "heart_rates", force: :cascade do |t|
    t.integer  "beats"
    t.date     "measurement_date"
    t.string   "measurement_source", limit: 255
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "heart_rates", ["owner_id"], name: "index_heart_rates_on_owner_id", using: :btree

  create_table "heights", force: :cascade do |t|
    t.decimal  "height_amount",                  precision: 10, scale: 2
    t.integer  "amount_type"
    t.date     "measurement_date"
    t.string   "measurement_source", limit: 255
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "heights", ["owner_id"], name: "index_heights_on_owner_id", using: :btree

  create_table "hobbies", force: :cascade do |t|
    t.string   "hobby_name",  limit: 255
    t.text     "notes"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "hobbies", ["owner_id"], name: "index_hobbies_on_owner_id", using: :btree

  create_table "hypotheses", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "notes"
    t.integer  "question_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "hypotheses", ["owner_id"], name: "index_hypotheses_on_owner_id", using: :btree
  add_index "hypotheses", ["question_id"], name: "index_hypotheses_on_question_id", using: :btree

  create_table "hypothesis_experiments", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.text     "notes"
    t.date     "started"
    t.date     "ended"
    t.integer  "hypothesis_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hypothesis_experiments", ["hypothesis_id"], name: "index_hypothesis_experiments_on_hypothesis_id", using: :btree
  add_index "hypothesis_experiments", ["owner_id"], name: "index_hypothesis_experiments_on_owner_id", using: :btree

  create_table "ideas", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "idea"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "ideas", ["owner_id"], name: "index_ideas_on_owner_id", using: :btree

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "points"
    t.string   "name",                 limit: 255
    t.date     "birthday"
    t.text     "notes"
    t.text     "notepad"
    t.string   "nickname",             limit: 255
    t.text     "likes"
    t.text     "gift_ideas"
    t.string   "ktn",                  limit: 255
    t.text     "new_years_resolution"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "identity_drivers_licenses", force: :cascade do |t|
    t.string   "identifier",       limit: 255
    t.string   "region",           limit: 255
    t.string   "sub_region1",      limit: 255
    t.date     "expires"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "identity_file_id"
    t.integer  "owner_id"
  end

  add_index "identity_drivers_licenses", ["identity_id"], name: "index_identity_drivers_licenses_on_identity_id", using: :btree

  create_table "identity_emails", force: :cascade do |t|
    t.string   "email",       limit: 255
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
  end

  add_index "identity_emails", ["identity_id"], name: "index_identity_emails_on_identity_id", using: :btree
  add_index "identity_emails", ["owner_id"], name: "index_identity_emails_on_owner_id", using: :btree

  create_table "identity_file_folders", force: :cascade do |t|
    t.string   "folder_name",      limit: 255
    t.integer  "parent_folder_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "identity_file_folders", ["owner_id"], name: "index_identity_file_folders_on_owner_id", using: :btree
  add_index "identity_file_folders", ["parent_folder_id"], name: "index_identity_file_folders_on_parent_folder_id", using: :btree

  create_table "identity_file_shares", force: :cascade do |t|
    t.integer  "identity_file_id"
    t.integer  "share_id"
    t.integer  "owner_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "identity_file_shares", ["identity_file_id"], name: "index_identity_file_shares_on_identity_file_id", using: :btree
  add_index "identity_file_shares", ["owner_id"], name: "index_identity_file_shares_on_owner_id", using: :btree
  add_index "identity_file_shares", ["share_id"], name: "index_identity_file_shares_on_share_id", using: :btree

  create_table "identity_files", force: :cascade do |t|
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name",        limit: 255
    t.string   "file_content_type",     limit: 255
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "encrypted_password_id"
    t.text     "notes"
    t.integer  "folder_id"
    t.binary   "thumbnail_contents"
    t.integer  "thumbnail_bytes"
    t.integer  "visit_count"
    t.string   "filesystem_path"
  end

  add_index "identity_files", ["encrypted_password_id"], name: "index_identity_files_on_encrypted_password_id", using: :btree
  add_index "identity_files", ["folder_id"], name: "index_identity_files_on_folder_id", using: :btree
  add_index "identity_files", ["owner_id"], name: "index_identity_files_on_owner_id", using: :btree

  create_table "identity_locations", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
  end

  add_index "identity_locations", ["identity_id"], name: "index_identity_locations_on_identity_id", using: :btree
  add_index "identity_locations", ["location_id"], name: "index_identity_locations_on_location_id", using: :btree
  add_index "identity_locations", ["owner_id"], name: "index_identity_locations_on_owner_id", using: :btree

  create_table "identity_phones", force: :cascade do |t|
    t.string   "number",      limit: 255
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.integer  "phone_type"
  end

  add_index "identity_phones", ["identity_id"], name: "index_identity_phones_on_identity_id", using: :btree
  add_index "identity_phones", ["owner_id"], name: "index_identity_phones_on_owner_id", using: :btree

  create_table "identity_pictures", force: :cascade do |t|
    t.integer  "identity_id"
    t.integer  "identity_file_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identity_pictures", ["identity_file_id"], name: "index_identity_pictures_on_identity_file_id", using: :btree
  add_index "identity_pictures", ["identity_id"], name: "index_identity_pictures_on_identity_id", using: :btree
  add_index "identity_pictures", ["owner_id"], name: "index_identity_pictures_on_owner_id", using: :btree

  create_table "identity_relationships", force: :cascade do |t|
    t.integer  "contact_id"
    t.integer  "relationship_type"
    t.integer  "owner_id"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identity_relationships", ["contact_id"], name: "index_identity_relationships_on_contact_id", using: :btree
  add_index "identity_relationships", ["identity_id"], name: "index_identity_relationships_on_identity_id", using: :btree
  add_index "identity_relationships", ["owner_id"], name: "index_identity_relationships_on_owner_id", using: :btree

  create_table "job_salaries", force: :cascade do |t|
    t.integer  "owner_id"
    t.integer  "job_id"
    t.date     "started"
    t.date     "ended"
    t.text     "notes"
    t.decimal  "salary",        precision: 10, scale: 2
    t.integer  "salary_period"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "job_salaries", ["job_id"], name: "index_job_salaries_on_job_id", using: :btree
  add_index "job_salaries", ["owner_id"], name: "index_job_salaries_on_owner_id", using: :btree

  create_table "jobs", force: :cascade do |t|
    t.string   "job_title",             limit: 255
    t.integer  "company_id"
    t.date     "started"
    t.date     "ended"
    t.integer  "manager_contact_id"
    t.text     "notes"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "days_holiday"
    t.integer  "days_vacation"
    t.string   "employee_identifier",   limit: 255
    t.string   "department_name",       limit: 255
    t.string   "division_name",         limit: 255
    t.string   "business_unit",         limit: 255
    t.string   "email",                 limit: 255
    t.string   "internal_mail_id",      limit: 255
    t.string   "internal_mail_server",  limit: 255
    t.integer  "internal_address_id"
    t.string   "department_identifier", limit: 255
    t.string   "division_identifier",   limit: 255
    t.string   "personnel_code",        limit: 255
    t.integer  "visit_count"
  end

  add_index "jobs", ["company_id"], name: "index_jobs_on_company_id", using: :btree
  add_index "jobs", ["internal_address_id"], name: "index_jobs_on_internal_address_id", using: :btree
  add_index "jobs", ["manager_contact_id"], name: "index_jobs_on_manager_contact_id", using: :btree
  add_index "jobs", ["owner_id"], name: "index_jobs_on_owner_id", using: :btree

  create_table "jokes", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "joke"
    t.string   "source",      limit: 255
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "jokes", ["owner_id"], name: "index_jokes_on_owner_id", using: :btree

  create_table "life_goals", force: :cascade do |t|
    t.string   "life_goal_name", limit: 255
    t.text     "notes"
    t.integer  "position"
    t.datetime "goal_started"
    t.datetime "goal_ended"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "life_goals", ["owner_id"], name: "index_life_goals_on_owner_id", using: :btree

  create_table "life_insurances", force: :cascade do |t|
    t.string   "insurance_name",      limit: 255
    t.integer  "company_id"
    t.decimal  "insurance_amount",                precision: 10, scale: 2
    t.date     "started"
    t.integer  "periodic_payment_id"
    t.text     "notes"
    t.integer  "owner_id"
    t.integer  "life_insurance_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "life_insurances", ["company_id"], name: "index_life_insurances_on_company_id", using: :btree
  add_index "life_insurances", ["owner_id"], name: "index_life_insurances_on_owner_id", using: :btree
  add_index "life_insurances", ["periodic_payment_id"], name: "index_life_insurances_on_periodic_payment_id", using: :btree

  create_table "list_items", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
  end

  add_index "list_items", ["list_id"], name: "index_list_items_on_list_id", using: :btree
  add_index "list_items", ["owner_id"], name: "index_list_items_on_owner_id", using: :btree

  create_table "lists", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "lists", ["owner_id"], name: "index_lists_on_owner_id", using: :btree

  create_table "loans", force: :cascade do |t|
    t.string   "lender",          limit: 255
    t.decimal  "amount",                      precision: 10, scale: 2
    t.date     "start"
    t.date     "paid_off"
    t.decimal  "monthly_payment",             precision: 10, scale: 2
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "loans", ["owner_id"], name: "index_loans_on_owner_id", using: :btree

  create_table "location_phones", force: :cascade do |t|
    t.string   "number",      limit: 255
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
  end

  add_index "location_phones", ["location_id"], name: "index_location_phones_on_location_id", using: :btree
  add_index "location_phones", ["owner_id"], name: "index_location_phones_on_owner_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "address1",    limit: 255
    t.string   "address2",    limit: 255
    t.string   "address3",    limit: 255
    t.string   "region",      limit: 255
    t.string   "sub_region1", limit: 255
    t.string   "sub_region2", limit: 255
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "postal_code", limit: 255
    t.text     "notes"
    t.decimal  "latitude",                precision: 12, scale: 8
    t.decimal  "longitude",               precision: 12, scale: 8
    t.integer  "visit_count"
  end

  add_index "locations", ["owner_id"], name: "index_locations_on_owner_id", using: :btree

  create_table "meal_drinks", force: :cascade do |t|
    t.integer  "owner_id"
    t.integer  "meal_id"
    t.integer  "drink_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "drink_servings", precision: 10, scale: 2
  end

  add_index "meal_drinks", ["drink_id"], name: "index_meal_drinks_on_drink_id", using: :btree
  add_index "meal_drinks", ["meal_id"], name: "index_meal_drinks_on_meal_id", using: :btree
  add_index "meal_drinks", ["owner_id"], name: "index_meal_drinks_on_owner_id", using: :btree

  create_table "meal_foods", force: :cascade do |t|
    t.integer  "owner_id"
    t.integer  "meal_id"
    t.integer  "food_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "food_servings", precision: 10, scale: 2
  end

  add_index "meal_foods", ["food_id"], name: "index_meal_foods_on_food_id", using: :btree
  add_index "meal_foods", ["meal_id"], name: "index_meal_foods_on_meal_id", using: :btree
  add_index "meal_foods", ["owner_id"], name: "index_meal_foods_on_owner_id", using: :btree

  create_table "meal_vitamins", force: :cascade do |t|
    t.integer  "owner_id"
    t.integer  "meal_id"
    t.integer  "vitamin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "meal_vitamins", ["meal_id"], name: "index_meal_vitamins_on_meal_id", using: :btree
  add_index "meal_vitamins", ["owner_id"], name: "index_meal_vitamins_on_owner_id", using: :btree
  add_index "meal_vitamins", ["vitamin_id"], name: "index_meal_vitamins_on_vitamin_id", using: :btree

  create_table "meals", force: :cascade do |t|
    t.datetime "meal_time"
    t.text     "notes"
    t.integer  "location_id"
    t.decimal  "price",       precision: 10, scale: 2
    t.decimal  "calories",    precision: 10, scale: 2
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "meals", ["location_id"], name: "index_meals_on_location_id", using: :btree
  add_index "meals", ["owner_id"], name: "index_meals_on_owner_id", using: :btree

  create_table "medical_condition_instances", force: :cascade do |t|
    t.datetime "condition_start"
    t.datetime "condition_end"
    t.text     "notes"
    t.integer  "medical_condition_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "medical_condition_instances", ["medical_condition_id"], name: "index_medical_condition_instances_on_medical_condition_id", using: :btree
  add_index "medical_condition_instances", ["owner_id"], name: "index_medical_condition_instances_on_owner_id", using: :btree

  create_table "medical_conditions", force: :cascade do |t|
    t.string   "medical_condition_name", limit: 255
    t.text     "notes"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "medical_conditions", ["owner_id"], name: "index_medical_conditions_on_owner_id", using: :btree

  create_table "medicine_usage_medicines", force: :cascade do |t|
    t.integer  "owner_id"
    t.integer  "medicine_usage_id"
    t.integer  "medicine_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "medicine_usage_medicines", ["medicine_id"], name: "index_medicine_usage_medicines_on_medicine_id", using: :btree
  add_index "medicine_usage_medicines", ["medicine_usage_id"], name: "index_medicine_usage_medicines_on_medicine_usage_id", using: :btree
  add_index "medicine_usage_medicines", ["owner_id"], name: "index_medicine_usage_medicines_on_owner_id", using: :btree

  create_table "medicine_usages", force: :cascade do |t|
    t.datetime "usage_time"
    t.integer  "medicine_id"
    t.text     "usage_notes"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "medicine_usages", ["medicine_id"], name: "index_medicine_usages_on_medicine_id", using: :btree
  add_index "medicine_usages", ["owner_id"], name: "index_medicine_usages_on_owner_id", using: :btree

  create_table "medicines", force: :cascade do |t|
    t.string   "medicine_name", limit: 255
    t.decimal  "dosage",                    precision: 10, scale: 2
    t.integer  "dosage_type"
    t.text     "notes"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "medicines", ["owner_id"], name: "index_medicines_on_owner_id", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
    t.integer  "periodic_payment_id"
    t.integer  "visit_count"
    t.string   "membership_identifier", limit: 255
  end

  add_index "memberships", ["owner_id"], name: "index_memberships_on_owner_id", using: :btree
  add_index "memberships", ["periodic_payment_id"], name: "index_memberships_on_periodic_payment_id", using: :btree

  create_table "money_balance_items", force: :cascade do |t|
    t.integer  "money_balance_id"
    t.integer  "owner_id"
    t.decimal  "amount",                  precision: 10, scale: 2
    t.datetime "item_time"
    t.string   "money_balance_item_name"
    t.text     "notes"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "money_balance_items", ["money_balance_id"], name: "index_money_balance_items_on_money_balance_id", using: :btree
  add_index "money_balance_items", ["owner_id"], name: "index_money_balance_items_on_owner_id", using: :btree

  create_table "money_balances", force: :cascade do |t|
    t.integer  "contact_id"
    t.text     "notes"
    t.integer  "visit_count"
    t.integer  "owner_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "money_balances", ["contact_id"], name: "index_money_balances_on_contact_id", using: :btree
  add_index "money_balances", ["owner_id"], name: "index_money_balances_on_owner_id", using: :btree

  create_table "movie_theaters", force: :cascade do |t|
    t.string   "theater_name", limit: 255
    t.integer  "location_id"
    t.integer  "visit_count"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movie_theaters", ["location_id"], name: "index_movie_theaters_on_location_id", using: :btree
  add_index "movie_theaters", ["owner_id"], name: "index_movie_theaters_on_owner_id", using: :btree

  create_table "movies", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.datetime "watched"
    t.string   "url",            limit: 255
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.integer  "recommender_id"
  end

  add_index "movies", ["owner_id"], name: "index_movies_on_owner_id", using: :btree
  add_index "movies", ["recommender_id"], name: "index_movies_on_recommender_id", using: :btree

  create_table "museums", force: :cascade do |t|
    t.integer  "location_id"
    t.string   "museum_id",     limit: 255
    t.integer  "website_id"
    t.integer  "museum_type"
    t.text     "notes"
    t.integer  "visit_count"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "museum_source", limit: 255
  end

  add_index "museums", ["location_id"], name: "index_museums_on_location_id", using: :btree
  add_index "museums", ["owner_id"], name: "index_museums_on_owner_id", using: :btree
  add_index "museums", ["website_id"], name: "index_museums_on_website_id", using: :btree

  create_table "musical_groups", force: :cascade do |t|
    t.string   "musical_group_name", limit: 255
    t.text     "notes"
    t.datetime "listened"
    t.integer  "rating"
    t.boolean  "awesome"
    t.boolean  "secret"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "musical_genre",      limit: 255
    t.integer  "visit_count"
  end

  add_index "musical_groups", ["owner_id"], name: "index_musical_groups_on_owner_id", using: :btree

  create_table "myplaceonline_due_displays", force: :cascade do |t|
    t.boolean  "trash"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.integer  "exercise_threshold"
    t.integer  "contact_best_friend_threshold"
    t.integer  "contact_good_friend_threshold"
    t.integer  "contact_acquaintance_threshold"
    t.integer  "contact_best_family_threshold"
    t.integer  "contact_good_family_threshold"
    t.integer  "dentist_visit_threshold"
    t.integer  "doctor_visit_threshold"
    t.integer  "status_threshold"
    t.integer  "trash_pickup_threshold"
    t.integer  "periodic_payment_before_threshold"
    t.integer  "periodic_payment_after_threshold"
    t.integer  "drivers_license_expiration_threshold"
    t.integer  "birthday_threshold"
    t.integer  "promotion_threshold"
    t.integer  "gun_registration_expiration_threshold"
    t.integer  "event_threshold"
    t.integer  "stocks_vest_threshold"
    t.integer  "todo_threshold"
    t.integer  "vehicle_service_threshold"
  end

  add_index "myplaceonline_due_displays", ["owner_id"], name: "index_myplaceonline_due_displays_on_owner_id", using: :btree

  create_table "myplaceonline_quick_category_displays", force: :cascade do |t|
    t.boolean  "trash"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "myplaceonline_quick_category_displays", ["owner_id"], name: "index_myplaceonline_quick_category_displays_on_owner_id", using: :btree

  create_table "myplaceonline_searches", force: :cascade do |t|
    t.integer  "owner_id"
    t.boolean  "trash"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "myplaceonline_searches", ["owner_id"], name: "index_myplaceonline_searches_on_owner_id", using: :btree

  create_table "myplets", force: :cascade do |t|
    t.integer  "x_coordinate"
    t.integer  "y_coordinate"
    t.string   "title",         limit: 255
    t.string   "category_name", limit: 255
    t.integer  "category_id"
    t.integer  "border_type"
    t.boolean  "collapsed"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "myplets", ["owner_id"], name: "index_myplets_on_owner_id", using: :btree

  create_table "notepads", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.text     "notepad_data"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "notepads", ["owner_id"], name: "index_notepads_on_owner_id", using: :btree

  create_table "pains", force: :cascade do |t|
    t.string   "pain_location",   limit: 255
    t.integer  "intensity"
    t.datetime "pain_start_time"
    t.datetime "pain_end_time"
    t.text     "notes"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "pains", ["owner_id"], name: "index_pains_on_owner_id", using: :btree

  create_table "passport_pictures", force: :cascade do |t|
    t.integer  "passport_id"
    t.integer  "identity_file_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "passport_pictures", ["identity_file_id"], name: "index_passport_pictures_on_identity_file_id", using: :btree
  add_index "passport_pictures", ["owner_id"], name: "index_passport_pictures_on_owner_id", using: :btree
  add_index "passport_pictures", ["passport_id"], name: "index_passport_pictures_on_passport_id", using: :btree

  create_table "passports", force: :cascade do |t|
    t.string   "region",            limit: 255
    t.string   "passport_number",   limit: 255
    t.date     "expires"
    t.date     "issued"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "issuing_authority", limit: 255
    t.string   "name",              limit: 255
    t.integer  "visit_count"
    t.text     "notes"
  end

  add_index "passports", ["owner_id"], name: "index_passports_on_owner_id", using: :btree

  create_table "password_secrets", force: :cascade do |t|
    t.string   "question",            limit: 255
    t.string   "answer",              limit: 255
    t.integer  "answer_encrypted_id"
    t.integer  "password_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
  end

  add_index "password_secrets", ["answer_encrypted_id"], name: "index_password_secrets_on_answer_encrypted_id", using: :btree
  add_index "password_secrets", ["owner_id"], name: "index_password_secrets_on_owner_id", using: :btree
  add_index "password_secrets", ["password_id"], name: "index_password_secrets_on_password_id", using: :btree

  create_table "passwords", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.string   "user",                  limit: 255
    t.string   "password",              limit: 255
    t.string   "url",                   limit: 2000
    t.text     "notes"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "password_encrypted_id"
    t.string   "account_number",        limit: 255
    t.datetime "defunct"
    t.string   "email",                 limit: 255
    t.integer  "visit_count"
  end

  add_index "passwords", ["owner_id"], name: "index_passwords_on_owner_id", using: :btree
  add_index "passwords", ["password_encrypted_id"], name: "index_passwords_on_password_encrypted_id", using: :btree

  create_table "periodic_payments", force: :cascade do |t|
    t.string   "periodic_payment_name", limit: 255
    t.text     "notes"
    t.date     "started"
    t.date     "ended"
    t.integer  "date_period"
    t.decimal  "payment_amount",                    precision: 10, scale: 2
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.boolean  "suppress_reminder"
    t.integer  "password_id"
  end

  add_index "periodic_payments", ["owner_id"], name: "index_periodic_payments_on_owner_id", using: :btree
  add_index "periodic_payments", ["password_id"], name: "index_periodic_payments_on_password_id", using: :btree

  create_table "permissions", force: :cascade do |t|
    t.integer  "action"
    t.string   "subject_class"
    t.integer  "subject_id"
    t.integer  "visit_count"
    t.integer  "owner_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
  end

  add_index "permissions", ["owner_id"], name: "index_permissions_on_owner_id", using: :btree
  add_index "permissions", ["user_id"], name: "index_permissions_on_user_id", using: :btree

  create_table "phones", force: :cascade do |t|
    t.string   "phone_model_name",         limit: 255
    t.string   "phone_number",             limit: 255
    t.integer  "manufacturer_id"
    t.date     "purchased"
    t.decimal  "price",                                precision: 10, scale: 2
    t.integer  "operating_system"
    t.string   "operating_system_version", limit: 255
    t.integer  "max_resolution_width"
    t.integer  "max_resolution_height"
    t.integer  "ram"
    t.integer  "num_cpus"
    t.integer  "num_cores_per_cpu"
    t.boolean  "hyperthreaded"
    t.decimal  "max_cpu_speed",                        precision: 10, scale: 2
    t.boolean  "cdma"
    t.boolean  "gsm"
    t.decimal  "front_camera_megapixels",              precision: 10, scale: 2
    t.decimal  "back_camera_megapixels",               precision: 10, scale: 2
    t.text     "notes"
    t.integer  "owner_id"
    t.integer  "password_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dimensions_type"
    t.decimal  "width",                                precision: 10, scale: 2
    t.decimal  "height",                               precision: 10, scale: 2
    t.decimal  "depth",                                precision: 10, scale: 2
    t.integer  "weight_type"
    t.decimal  "weight",                               precision: 10, scale: 2
    t.integer  "visit_count"
  end

  add_index "phones", ["manufacturer_id"], name: "index_phones_on_manufacturer_id", using: :btree
  add_index "phones", ["owner_id"], name: "index_phones_on_owner_id", using: :btree
  add_index "phones", ["password_id"], name: "index_phones_on_password_id", using: :btree

  create_table "playlist_share_contacts", force: :cascade do |t|
    t.integer  "playlist_share_id"
    t.integer  "contact_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "playlist_share_contacts", ["contact_id"], name: "index_playlist_share_contacts_on_contact_id", using: :btree
  add_index "playlist_share_contacts", ["owner_id"], name: "index_playlist_share_contacts_on_owner_id", using: :btree
  add_index "playlist_share_contacts", ["playlist_share_id"], name: "index_playlist_share_contacts_on_playlist_share_id", using: :btree

  create_table "playlist_shares", force: :cascade do |t|
    t.boolean  "email"
    t.integer  "playlist_id"
    t.integer  "owner_id"
    t.string   "subject",     limit: 255
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "copy_self"
    t.integer  "share_id"
    t.integer  "visit_count"
  end

  add_index "playlist_shares", ["owner_id"], name: "index_playlist_shares_on_owner_id", using: :btree
  add_index "playlist_shares", ["playlist_id"], name: "index_playlist_shares_on_playlist_id", using: :btree
  add_index "playlist_shares", ["share_id"], name: "index_playlist_shares_on_share_id", using: :btree

  create_table "playlist_songs", force: :cascade do |t|
    t.integer  "playlist_id"
    t.integer  "song_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "playlist_songs", ["owner_id"], name: "index_playlist_songs_on_owner_id", using: :btree
  add_index "playlist_songs", ["playlist_id"], name: "index_playlist_songs_on_playlist_id", using: :btree
  add_index "playlist_songs", ["song_id"], name: "index_playlist_songs_on_song_id", using: :btree

  create_table "playlists", force: :cascade do |t|
    t.string   "playlist_name",    limit: 255
    t.integer  "visit_count"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "identity_file_id"
  end

  add_index "playlists", ["identity_file_id"], name: "index_playlists_on_identity_file_id", using: :btree
  add_index "playlists", ["owner_id"], name: "index_playlists_on_owner_id", using: :btree

  create_table "poems", force: :cascade do |t|
    t.string   "poem_name",   limit: 255
    t.text     "poem"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "poems", ["owner_id"], name: "index_poems_on_owner_id", using: :btree

  create_table "point_displays", force: :cascade do |t|
    t.boolean  "trash"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "point_displays", ["owner_id"], name: "index_point_displays_on_owner_id", using: :btree

  create_table "promises", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.date     "due"
    t.text     "promise"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "promises", ["owner_id"], name: "index_promises_on_owner_id", using: :btree

  create_table "promotions", force: :cascade do |t|
    t.string   "promotion_name",   limit: 255
    t.date     "started"
    t.date     "expires"
    t.decimal  "promotion_amount",             precision: 10, scale: 2
    t.text     "notes"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "promotions", ["owner_id"], name: "index_promotions_on_owner_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "notes"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "questions", ["owner_id"], name: "index_questions_on_owner_id", using: :btree

  create_table "recipes", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "recipe"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "recipes", ["owner_id"], name: "index_recipes_on_owner_id", using: :btree

  create_table "recreational_vehicle_insurances", force: :cascade do |t|
    t.string   "insurance_name",          limit: 255
    t.integer  "company_id"
    t.date     "started"
    t.integer  "periodic_payment_id"
    t.text     "notes"
    t.integer  "recreational_vehicle_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recreational_vehicle_insurances", ["company_id"], name: "index_recreational_vehicle_insurances_on_company_id", using: :btree
  add_index "recreational_vehicle_insurances", ["owner_id"], name: "index_recreational_vehicle_insurances_on_owner_id", using: :btree
  add_index "recreational_vehicle_insurances", ["periodic_payment_id"], name: "index_recreational_vehicle_insurances_on_periodic_payment_id", using: :btree

  create_table "recreational_vehicle_loans", force: :cascade do |t|
    t.integer  "recreational_vehicle_id"
    t.integer  "loan_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recreational_vehicle_loans", ["loan_id"], name: "index_recreational_vehicle_loans_on_loan_id", using: :btree
  add_index "recreational_vehicle_loans", ["owner_id"], name: "index_recreational_vehicle_loans_on_owner_id", using: :btree
  add_index "recreational_vehicle_loans", ["recreational_vehicle_id"], name: "index_recreational_vehicle_loans_on_recreational_vehicle_id", using: :btree

  create_table "recreational_vehicle_measurements", force: :cascade do |t|
    t.string   "measurement_name",        limit: 255
    t.integer  "measurement_type"
    t.decimal  "width",                               precision: 10, scale: 2
    t.decimal  "height",                              precision: 10, scale: 2
    t.decimal  "depth",                               precision: 10, scale: 2
    t.text     "notes"
    t.integer  "owner_id"
    t.integer  "recreational_vehicle_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recreational_vehicle_measurements", ["owner_id"], name: "index_recreational_vehicle_measurements_on_owner_id", using: :btree

  create_table "recreational_vehicle_pictures", force: :cascade do |t|
    t.integer  "recreational_vehicle_id"
    t.integer  "identity_file_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recreational_vehicle_pictures", ["identity_file_id"], name: "index_recreational_vehicle_pictures_on_identity_file_id", using: :btree
  add_index "recreational_vehicle_pictures", ["owner_id"], name: "index_recreational_vehicle_pictures_on_owner_id", using: :btree
  add_index "recreational_vehicle_pictures", ["recreational_vehicle_id"], name: "index_recreational_vehicle_pictures_on_recreational_vehicle_id", using: :btree

  create_table "recreational_vehicles", force: :cascade do |t|
    t.string   "rv_name",               limit: 255
    t.string   "vin",                   limit: 255
    t.string   "manufacturer",          limit: 255
    t.string   "model",                 limit: 255
    t.integer  "year"
    t.decimal  "price",                             precision: 10, scale: 2
    t.decimal  "msrp",                              precision: 10, scale: 2
    t.date     "purchased"
    t.date     "owned_start"
    t.date     "owned_end"
    t.text     "notes"
    t.integer  "location_purchased_id"
    t.integer  "vehicle_id"
    t.decimal  "wet_weight",                        precision: 10, scale: 2
    t.integer  "sleeps"
    t.integer  "dimensions_type"
    t.decimal  "exterior_length",                   precision: 10, scale: 2
    t.decimal  "exterior_width",                    precision: 10, scale: 2
    t.decimal  "exterior_height",                   precision: 10, scale: 2
    t.decimal  "exterior_height_over",              precision: 10, scale: 2
    t.decimal  "interior_height",                   precision: 10, scale: 2
    t.integer  "liquid_capacity_type"
    t.integer  "fresh_tank"
    t.integer  "grey_tank"
    t.integer  "black_tank"
    t.date     "warranty_ends"
    t.integer  "water_heater"
    t.integer  "propane"
    t.integer  "volume_type"
    t.integer  "weight_type"
    t.integer  "refrigerator"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "exterior_length_over",              precision: 10, scale: 2
    t.decimal  "slideouts_extra_width",             precision: 10, scale: 2
    t.decimal  "floor_length",                      precision: 10, scale: 2
    t.integer  "visit_count"
  end

  add_index "recreational_vehicles", ["location_purchased_id"], name: "index_recreational_vehicles_on_location_purchased_id", using: :btree
  add_index "recreational_vehicles", ["owner_id"], name: "index_recreational_vehicles_on_owner_id", using: :btree
  add_index "recreational_vehicles", ["vehicle_id"], name: "index_recreational_vehicles_on_vehicle_id", using: :btree

  create_table "repeats", force: :cascade do |t|
    t.date     "start_date"
    t.integer  "period_type"
    t.integer  "period"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "repeats", ["owner_id"], name: "index_repeats_on_owner_id", using: :btree

  create_table "restaurant_pictures", force: :cascade do |t|
    t.integer  "restaurant_id"
    t.integer  "identity_file_id"
    t.integer  "owner_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "restaurant_pictures", ["identity_file_id"], name: "index_restaurant_pictures_on_identity_file_id", using: :btree
  add_index "restaurant_pictures", ["owner_id"], name: "index_restaurant_pictures_on_owner_id", using: :btree
  add_index "restaurant_pictures", ["restaurant_id"], name: "index_restaurant_pictures_on_restaurant_id", using: :btree

  create_table "restaurants", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "rating"
    t.text     "notes"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "restaurants", ["location_id"], name: "index_restaurants_on_location_id", using: :btree
  add_index "restaurants", ["owner_id"], name: "index_restaurants_on_owner_id", using: :btree

  create_table "reward_programs", force: :cascade do |t|
    t.string   "reward_program_name",   limit: 255
    t.date     "started"
    t.date     "ended"
    t.string   "reward_program_number", limit: 255
    t.string   "reward_program_status", limit: 255
    t.text     "notes"
    t.integer  "password_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "program_type"
    t.integer  "visit_count"
  end

  add_index "reward_programs", ["owner_id"], name: "index_reward_programs_on_owner_id", using: :btree
  add_index "reward_programs", ["password_id"], name: "index_reward_programs_on_password_id", using: :btree

  create_table "shares", force: :cascade do |t|
    t.string   "token",      limit: 255
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shares", ["owner_id"], name: "index_shares_on_owner_id", using: :btree

  create_table "shopping_list_items", force: :cascade do |t|
    t.integer  "owner_id"
    t.integer  "shopping_list_id"
    t.string   "shopping_list_item_name", limit: 255
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shopping_list_items", ["owner_id"], name: "index_shopping_list_items_on_owner_id", using: :btree
  add_index "shopping_list_items", ["shopping_list_id"], name: "index_shopping_list_items_on_shopping_list_id", using: :btree

  create_table "shopping_lists", force: :cascade do |t|
    t.string   "shopping_list_name", limit: 255
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "shopping_lists", ["owner_id"], name: "index_shopping_lists_on_owner_id", using: :btree

  create_table "skin_treatments", force: :cascade do |t|
    t.datetime "treatment_time"
    t.string   "treatment_activity", limit: 255
    t.string   "treatment_location", limit: 255
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "skin_treatments", ["owner_id"], name: "index_skin_treatments_on_owner_id", using: :btree

  create_table "sleep_measurements", force: :cascade do |t|
    t.datetime "sleep_start_time"
    t.datetime "sleep_end_time"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "sleep_measurements", ["owner_id"], name: "index_sleep_measurements_on_owner_id", using: :btree

  create_table "snoozed_due_items", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "display",                      limit: 255
    t.string   "link",                         limit: 255
    t.datetime "due_date"
    t.datetime "original_due_date"
    t.string   "myp_model_name",               limit: 255
    t.integer  "model_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "myplaceonline_due_display_id"
  end

  add_index "snoozed_due_items", ["myplaceonline_due_display_id"], name: "index_snoozed_due_items_on_myplaceonline_due_display_id", using: :btree
  add_index "snoozed_due_items", ["owner_id"], name: "index_snoozed_due_items_on_owner_id", using: :btree

  create_table "songs", force: :cascade do |t|
    t.string   "song_name",        limit: 255
    t.decimal  "song_rating",                  precision: 10, scale: 2
    t.text     "lyrics"
    t.integer  "song_plays"
    t.datetime "lastplay"
    t.boolean  "secret"
    t.boolean  "awesome"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.integer  "identity_file_id"
    t.integer  "musical_group_id"
  end

  add_index "songs", ["identity_file_id"], name: "index_songs_on_identity_file_id", using: :btree
  add_index "songs", ["musical_group_id"], name: "index_songs_on_musical_group_id", using: :btree
  add_index "songs", ["owner_id"], name: "index_songs_on_owner_id", using: :btree

  create_table "statuses", force: :cascade do |t|
    t.datetime "status_time"
    t.text     "three_good_things"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "feeling"
    t.integer  "visit_count"
    t.string   "status1",           limit: 255
    t.string   "status2",           limit: 255
    t.string   "status3",           limit: 255
  end

  add_index "statuses", ["owner_id"], name: "index_statuses_on_owner_id", using: :btree

  create_table "stocks", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "num_shares"
    t.text     "notes"
    t.date     "vest_date"
    t.integer  "password_id"
    t.integer  "visit_count"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stocks", ["company_id"], name: "index_stocks_on_company_id", using: :btree
  add_index "stocks", ["owner_id"], name: "index_stocks_on_owner_id", using: :btree
  add_index "stocks", ["password_id"], name: "index_stocks_on_password_id", using: :btree

  create_table "sun_exposures", force: :cascade do |t|
    t.datetime "exposure_start"
    t.datetime "exposure_end"
    t.string   "uncovered_body_parts",   limit: 255
    t.string   "sunscreened_body_parts", limit: 255
    t.string   "sunscreen_type",         limit: 255
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "sun_exposures", ["owner_id"], name: "index_sun_exposures_on_owner_id", using: :btree

  create_table "temperatures", force: :cascade do |t|
    t.datetime "measured"
    t.decimal  "measured_temperature",             precision: 10, scale: 2
    t.string   "measurement_source",   limit: 255
    t.integer  "temperature_type"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "temperatures", ["owner_id"], name: "index_temperatures_on_owner_id", using: :btree

  create_table "therapists", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "notes"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contact_id"
    t.integer  "visit_count"
  end

  add_index "therapists", ["contact_id"], name: "index_therapists_on_contact_id", using: :btree
  add_index "therapists", ["owner_id"], name: "index_therapists_on_owner_id", using: :btree

  create_table "to_dos", force: :cascade do |t|
    t.string   "short_description", limit: 255
    t.text     "notes"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "due_time"
  end

  add_index "to_dos", ["owner_id"], name: "index_to_dos_on_owner_id", using: :btree

  create_table "trek_pictures", force: :cascade do |t|
    t.integer  "trek_id"
    t.integer  "identity_file_id"
    t.integer  "owner_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "trek_pictures", ["identity_file_id"], name: "index_trek_pictures_on_identity_file_id", using: :btree
  add_index "trek_pictures", ["owner_id"], name: "index_trek_pictures_on_owner_id", using: :btree
  add_index "trek_pictures", ["trek_id"], name: "index_trek_pictures_on_trek_id", using: :btree

  create_table "treks", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "rating"
    t.text     "notes"
    t.integer  "visit_count"
    t.integer  "owner_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "treks", ["location_id"], name: "index_treks_on_location_id", using: :btree
  add_index "treks", ["owner_id"], name: "index_treks_on_owner_id", using: :btree

  create_table "trip_pictures", force: :cascade do |t|
    t.integer  "owner_id"
    t.integer  "trip_id"
    t.integer  "identity_file_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trip_pictures", ["identity_file_id"], name: "index_trip_pictures_on_identity_file_id", using: :btree
  add_index "trip_pictures", ["owner_id"], name: "index_trip_pictures_on_owner_id", using: :btree
  add_index "trip_pictures", ["trip_id"], name: "index_trip_pictures_on_trip_id", using: :btree

  create_table "trips", force: :cascade do |t|
    t.integer  "location_id"
    t.date     "started"
    t.date     "ended"
    t.text     "notes"
    t.boolean  "work"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "trips", ["location_id"], name: "index_trips_on_location_id", using: :btree
  add_index "trips", ["owner_id"], name: "index_trips_on_owner_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                       limit: 255, default: "",    null: false
    t.string   "encrypted_password",          limit: 255, default: "",    null: false
    t.string   "reset_password_token",        limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                           default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "primary_identity_id"
    t.string   "confirmation_token",          limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                         default: 0
    t.string   "unlock_token",                limit: 255
    t.datetime "locked_at"
    t.string   "unconfirmed_email",           limit: 255
    t.boolean  "encrypt_by_default",                      default: false
    t.string   "timezone",                    limit: 255
    t.integer  "page_transition"
    t.integer  "clipboard_integration"
    t.boolean  "explicit_categories"
    t.integer  "user_type"
    t.boolean  "clipboard_transform_numbers"
    t.integer  "visit_count"
    t.boolean  "enable_sounds"
    t.boolean  "always_autofocus"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "vehicle_insurances", force: :cascade do |t|
    t.string   "insurance_name",      limit: 255
    t.integer  "company_id"
    t.date     "started"
    t.integer  "periodic_payment_id"
    t.integer  "vehicle_id"
    t.text     "notes"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vehicle_insurances", ["company_id"], name: "index_vehicle_insurances_on_company_id", using: :btree
  add_index "vehicle_insurances", ["owner_id"], name: "index_vehicle_insurances_on_owner_id", using: :btree
  add_index "vehicle_insurances", ["periodic_payment_id"], name: "index_vehicle_insurances_on_periodic_payment_id", using: :btree
  add_index "vehicle_insurances", ["vehicle_id"], name: "index_vehicle_insurances_on_vehicle_id", using: :btree

  create_table "vehicle_loans", force: :cascade do |t|
    t.integer  "vehicle_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "loan_id"
    t.integer  "owner_id"
  end

  add_index "vehicle_loans", ["owner_id"], name: "index_vehicle_loans_on_owner_id", using: :btree
  add_index "vehicle_loans", ["vehicle_id"], name: "index_vehicle_loans_on_vehicle_id", using: :btree

  create_table "vehicle_pictures", force: :cascade do |t|
    t.integer  "vehicle_id"
    t.integer  "identity_file_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vehicle_pictures", ["identity_file_id"], name: "index_vehicle_pictures_on_identity_file_id", using: :btree
  add_index "vehicle_pictures", ["owner_id"], name: "index_vehicle_pictures_on_owner_id", using: :btree
  add_index "vehicle_pictures", ["vehicle_id"], name: "index_vehicle_pictures_on_vehicle_id", using: :btree

  create_table "vehicle_services", force: :cascade do |t|
    t.integer  "vehicle_id"
    t.text     "notes"
    t.string   "short_description", limit: 255
    t.date     "date_due"
    t.date     "date_serviced"
    t.text     "service_location"
    t.decimal  "cost",                          precision: 10, scale: 2
    t.integer  "miles"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
  end

  add_index "vehicle_services", ["owner_id"], name: "index_vehicle_services_on_owner_id", using: :btree
  add_index "vehicle_services", ["vehicle_id"], name: "index_vehicle_services_on_vehicle_id", using: :btree

  create_table "vehicle_warranties", force: :cascade do |t|
    t.integer  "owner_id"
    t.integer  "warranty_id"
    t.integer  "vehicle_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vehicle_warranties", ["owner_id"], name: "index_vehicle_warranties_on_owner_id", using: :btree
  add_index "vehicle_warranties", ["vehicle_id"], name: "index_vehicle_warranties_on_vehicle_id", using: :btree
  add_index "vehicle_warranties", ["warranty_id"], name: "index_vehicle_warranties_on_warranty_id", using: :btree

  create_table "vehicles", force: :cascade do |t|
    t.string   "name",                     limit: 255
    t.text     "notes"
    t.date     "owned_start"
    t.date     "owned_end"
    t.string   "vin",                      limit: 255
    t.string   "manufacturer",             limit: 255
    t.string   "model",                    limit: 255
    t.integer  "year"
    t.string   "color",                    limit: 255
    t.string   "license_plate",            limit: 255
    t.string   "region",                   limit: 255
    t.string   "sub_region1",              limit: 255
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "trim_name",                limit: 255
    t.integer  "dimensions_type"
    t.decimal  "height",                               precision: 10, scale: 2
    t.decimal  "width",                                precision: 10, scale: 2
    t.decimal  "length",                               precision: 10, scale: 2
    t.decimal  "wheel_base",                           precision: 10, scale: 2
    t.decimal  "ground_clearance",                     precision: 10, scale: 2
    t.integer  "weight_type"
    t.integer  "doors_type"
    t.integer  "passenger_seats"
    t.decimal  "gvwr",                                 precision: 10, scale: 2
    t.decimal  "gcwr",                                 precision: 10, scale: 2
    t.decimal  "gawr_front",                           precision: 10, scale: 2
    t.decimal  "gawr_rear",                            precision: 10, scale: 2
    t.string   "front_axle_details",       limit: 255
    t.decimal  "front_axle_rating",                    precision: 10, scale: 2
    t.string   "front_suspension_details", limit: 255
    t.decimal  "front_suspension_rating",              precision: 10, scale: 2
    t.string   "rear_axle_details",        limit: 255
    t.decimal  "rear_axle_rating",                     precision: 10, scale: 2
    t.string   "rear_suspension_details",  limit: 255
    t.decimal  "rear_suspension_rating",               precision: 10, scale: 2
    t.string   "tire_details",             limit: 255
    t.decimal  "tire_rating",                          precision: 10, scale: 2
    t.decimal  "tire_diameter",                        precision: 10, scale: 2
    t.string   "wheel_details",            limit: 255
    t.decimal  "wheel_rating",                         precision: 10, scale: 2
    t.integer  "engine_type"
    t.integer  "wheel_drive_type"
    t.integer  "wheels_type"
    t.integer  "fuel_tank_capacity_type"
    t.decimal  "fuel_tank_capacity",                   precision: 10, scale: 2
    t.decimal  "wet_weight_front",                     precision: 10, scale: 2
    t.decimal  "wet_weight_rear",                      precision: 10, scale: 2
    t.decimal  "tailgate_weight",                      precision: 10, scale: 2
    t.integer  "horsepower"
    t.integer  "cylinders"
    t.integer  "displacement_type"
    t.integer  "doors"
    t.decimal  "displacement",                         precision: 10, scale: 2
    t.decimal  "bed_length",                           precision: 10, scale: 2
    t.integer  "recreational_vehicle_id"
    t.decimal  "price",                                precision: 10, scale: 2
    t.decimal  "msrp",                                 precision: 10, scale: 2
    t.integer  "visit_count"
  end

  add_index "vehicles", ["owner_id"], name: "index_vehicles_on_owner_id", using: :btree

  create_table "vitamin_ingredients", force: :cascade do |t|
    t.integer  "owner_id"
    t.integer  "parent_vitamin_id"
    t.integer  "vitamin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vitamin_ingredients", ["owner_id"], name: "index_vitamin_ingredients_on_owner_id", using: :btree
  add_index "vitamin_ingredients", ["parent_vitamin_id"], name: "index_vitamin_ingredients_on_parent_vitamin_id", using: :btree
  add_index "vitamin_ingredients", ["vitamin_id"], name: "index_vitamin_ingredients_on_vitamin_id", using: :btree

  create_table "vitamins", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "vitamin_name",   limit: 255
    t.text     "notes"
    t.decimal  "vitamin_amount",             precision: 10, scale: 2
    t.integer  "amount_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "vitamins", ["owner_id"], name: "index_vitamins_on_owner_id", using: :btree

  create_table "warranties", force: :cascade do |t|
    t.string   "warranty_name",      limit: 255
    t.date     "warranty_start"
    t.date     "warranty_end"
    t.string   "warranty_condition", limit: 255
    t.text     "notes"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "warranties", ["owner_id"], name: "index_warranties_on_owner_id", using: :btree

  create_table "websites", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "url",         limit: 2000
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "websites", ["owner_id"], name: "index_websites_on_owner_id", using: :btree

  create_table "weights", force: :cascade do |t|
    t.decimal  "amount",                   precision: 10, scale: 2
    t.integer  "amount_type"
    t.date     "measure_date"
    t.string   "source",       limit: 255
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "weights", ["owner_id"], name: "index_weights_on_owner_id", using: :btree

  create_table "wisdoms", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "wisdom"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
  end

  add_index "wisdoms", ["owner_id"], name: "index_wisdoms_on_owner_id", using: :btree

  add_foreign_key "bar_pictures", "bars"
  add_foreign_key "bar_pictures", "identities", column: "owner_id"
  add_foreign_key "bar_pictures", "identity_files"
  add_foreign_key "bars", "identities", column: "owner_id"
  add_foreign_key "bars", "locations"
  add_foreign_key "concert_pictures", "concerts"
  add_foreign_key "concert_pictures", "identities", column: "owner_id"
  add_foreign_key "concert_pictures", "identity_files"
  add_foreign_key "event_pictures", "events"
  add_foreign_key "event_pictures", "identities", column: "owner_id"
  add_foreign_key "event_pictures", "identity_files"
  add_foreign_key "favorite_product_links", "favorite_products"
  add_foreign_key "favorite_product_links", "identities", column: "owner_id"
  add_foreign_key "identity_file_shares", "identity_files"
  add_foreign_key "identity_file_shares", "shares"
  add_foreign_key "money_balance_items", "identities", column: "owner_id"
  add_foreign_key "money_balance_items", "money_balances"
  add_foreign_key "money_balances", "contacts"
  add_foreign_key "money_balances", "identities", column: "owner_id"
  add_foreign_key "periodic_payments", "passwords"
  add_foreign_key "permissions", "identities", column: "owner_id"
  add_foreign_key "permissions", "users"
  add_foreign_key "playlist_shares", "shares"
  add_foreign_key "playlists", "identity_files"
  add_foreign_key "restaurant_pictures", "identities", column: "owner_id"
  add_foreign_key "restaurant_pictures", "identity_files"
  add_foreign_key "restaurant_pictures", "restaurants"
  add_foreign_key "trek_pictures", "identities", column: "owner_id"
  add_foreign_key "trek_pictures", "identity_files"
  add_foreign_key "trek_pictures", "treks"
  add_foreign_key "treks", "identities", column: "owner_id"
  add_foreign_key "treks", "locations"
end
