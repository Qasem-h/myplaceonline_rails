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

ActiveRecord::Schema.define(version: 20161011050519) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accomplishments", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.text     "accomplishment"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "accomplishments", ["identity_id"], name: "index_accomplishments_on_identity_id", using: :btree

  create_table "acne_measurement_pictures", force: :cascade do |t|
    t.integer  "acne_measurement_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "acne_measurement_pictures", ["acne_measurement_id"], name: "index_acne_measurement_pictures_on_acne_measurement_id", using: :btree
  add_index "acne_measurement_pictures", ["identity_file_id"], name: "index_acne_measurement_pictures_on_identity_file_id", using: :btree
  add_index "acne_measurement_pictures", ["identity_id"], name: "index_acne_measurement_pictures_on_identity_id", using: :btree

  create_table "acne_measurements", force: :cascade do |t|
    t.datetime "measurement_datetime"
    t.string   "acne_location",        limit: 255
    t.integer  "total_pimples"
    t.integer  "new_pimples"
    t.integer  "worrying_pimples"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "acne_measurements", ["identity_id"], name: "index_acne_measurements_on_identity_id", using: :btree

  create_table "activities", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.text     "notes"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "activities", ["identity_id"], name: "index_activities_on_identity_id", using: :btree

  create_table "admin_emails", force: :cascade do |t|
    t.integer  "email_id"
    t.integer  "identity_id"
    t.string   "send_only_to"
    t.string   "exclude_emails"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "admin_emails", ["email_id"], name: "index_admin_emails_on_email_id", using: :btree
  add_index "admin_emails", ["identity_id"], name: "index_admin_emails_on_identity_id", using: :btree

  create_table "admin_text_messages", force: :cascade do |t|
    t.integer  "text_message_id"
    t.integer  "identity_id"
    t.string   "send_only_to"
    t.string   "exclude_numbers"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "admin_text_messages", ["identity_id"], name: "index_admin_text_messages_on_identity_id", using: :btree
  add_index "admin_text_messages", ["text_message_id"], name: "index_admin_text_messages_on_text_message_id", using: :btree

  create_table "alerts_displays", force: :cascade do |t|
    t.integer  "identity_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "suppress_hotel"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "alerts_displays", ["identity_id"], name: "index_alerts_displays_on_identity_id", using: :btree

  create_table "annuities", force: :cascade do |t|
    t.string   "annuity_name"
    t.text     "notes"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "annuities", ["identity_id"], name: "index_annuities_on_identity_id", using: :btree

  create_table "apartment_lease_files", force: :cascade do |t|
    t.integer  "apartment_lease_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.integer  "position"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "apartment_lease_files", ["apartment_lease_id"], name: "index_apartment_lease_files_on_apartment_lease_id", using: :btree
  add_index "apartment_lease_files", ["identity_file_id"], name: "index_apartment_lease_files_on_identity_file_id", using: :btree
  add_index "apartment_lease_files", ["identity_id"], name: "index_apartment_lease_files_on_identity_id", using: :btree

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
    t.integer  "identity_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "apartment_leases", ["apartment_id"], name: "index_apartment_leases_on_apartment_id", using: :btree
  add_index "apartment_leases", ["identity_id"], name: "index_apartment_leases_on_identity_id", using: :btree

  create_table "apartment_pictures", force: :cascade do |t|
    t.integer  "apartment_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "apartment_pictures", ["apartment_id"], name: "index_apartment_pictures_on_apartment_id", using: :btree
  add_index "apartment_pictures", ["identity_file_id"], name: "index_apartment_pictures_on_identity_file_id", using: :btree
  add_index "apartment_pictures", ["identity_id"], name: "index_apartment_pictures_on_identity_id", using: :btree

  create_table "apartment_trash_pickups", force: :cascade do |t|
    t.integer  "trash_type"
    t.text     "notes"
    t.integer  "apartment_id"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "repeat_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "apartment_trash_pickups", ["apartment_id"], name: "index_apartment_trash_pickups_on_apartment_id", using: :btree
  add_index "apartment_trash_pickups", ["identity_id"], name: "index_apartment_trash_pickups_on_identity_id", using: :btree
  add_index "apartment_trash_pickups", ["repeat_id"], name: "index_apartment_trash_pickups_on_repeat_id", using: :btree

  create_table "apartments", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "landlord_id"
    t.text     "notes"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "apartments", ["identity_id"], name: "index_apartments_on_identity_id", using: :btree
  add_index "apartments", ["landlord_id"], name: "index_apartments_on_landlord_id", using: :btree
  add_index "apartments", ["location_id"], name: "index_apartments_on_location_id", using: :btree

  create_table "awesome_list_items", force: :cascade do |t|
    t.string   "item_name"
    t.integer  "awesome_list_id"
    t.integer  "identity_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "awesome_list_items", ["awesome_list_id"], name: "index_awesome_list_items_on_awesome_list_id", using: :btree
  add_index "awesome_list_items", ["identity_id"], name: "index_awesome_list_items_on_identity_id", using: :btree

  create_table "awesome_lists", force: :cascade do |t|
    t.integer  "location_id"
    t.text     "notes"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "awesome_lists", ["identity_id"], name: "index_awesome_lists_on_identity_id", using: :btree
  add_index "awesome_lists", ["location_id"], name: "index_awesome_lists_on_location_id", using: :btree

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
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "visit_count"
    t.integer  "rating"
  end

  add_index "bank_accounts", ["account_number_encrypted_id"], name: "index_bank_accounts_on_account_number_encrypted_id", using: :btree
  add_index "bank_accounts", ["company_id"], name: "index_bank_accounts_on_company_id", using: :btree
  add_index "bank_accounts", ["home_address_id"], name: "index_bank_accounts_on_home_address_id", using: :btree
  add_index "bank_accounts", ["identity_id"], name: "index_bank_accounts_on_identity_id", using: :btree
  add_index "bank_accounts", ["password_id"], name: "index_bank_accounts_on_password_id", using: :btree
  add_index "bank_accounts", ["pin_encrypted_id"], name: "index_bank_accounts_on_pin_encrypted_id", using: :btree
  add_index "bank_accounts", ["routing_number_encrypted_id"], name: "index_bank_accounts_on_routing_number_encrypted_id", using: :btree

  create_table "bar_pictures", force: :cascade do |t|
    t.integer  "bar_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "bar_pictures", ["bar_id"], name: "index_bar_pictures_on_bar_id", using: :btree
  add_index "bar_pictures", ["identity_file_id"], name: "index_bar_pictures_on_identity_file_id", using: :btree
  add_index "bar_pictures", ["identity_id"], name: "index_bar_pictures_on_identity_id", using: :btree

  create_table "bars", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "rating"
    t.text     "notes"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
  end

  add_index "bars", ["identity_id"], name: "index_bars_on_identity_id", using: :btree
  add_index "bars", ["location_id"], name: "index_bars_on_location_id", using: :btree

  create_table "bet_contacts", force: :cascade do |t|
    t.integer  "bet_id"
    t.integer  "identity_id"
    t.integer  "contact_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "bet_contacts", ["bet_id"], name: "index_bet_contacts_on_bet_id", using: :btree
  add_index "bet_contacts", ["contact_id"], name: "index_bet_contacts_on_contact_id", using: :btree
  add_index "bet_contacts", ["identity_id"], name: "index_bet_contacts_on_identity_id", using: :btree

  create_table "bets", force: :cascade do |t|
    t.string   "bet_name"
    t.date     "bet_start_date"
    t.date     "bet_end_date"
    t.decimal  "bet_amount",           precision: 10, scale: 2
    t.decimal  "odds_ratio",           precision: 10, scale: 2
    t.boolean  "odds_direction_owner"
    t.text     "notes"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "bets", ["identity_id"], name: "index_bets_on_identity_id", using: :btree

  create_table "blood_concentrations", force: :cascade do |t|
    t.string   "concentration_name",    limit: 255
    t.integer  "concentration_type"
    t.decimal  "concentration_minimum",             precision: 10, scale: 2
    t.decimal  "concentration_maximum",             precision: 10, scale: 2
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "blood_concentrations", ["identity_id"], name: "index_blood_concentrations_on_identity_id", using: :btree

  create_table "blood_pressures", force: :cascade do |t|
    t.integer  "systolic_pressure"
    t.integer  "diastolic_pressure"
    t.date     "measurement_date"
    t.string   "measurement_source", limit: 255
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "blood_pressures", ["identity_id"], name: "index_blood_pressures_on_identity_id", using: :btree

  create_table "blood_test_files", force: :cascade do |t|
    t.integer  "blood_test_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.integer  "position"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "blood_test_files", ["blood_test_id"], name: "index_blood_test_files_on_blood_test_id", using: :btree
  add_index "blood_test_files", ["identity_file_id"], name: "index_blood_test_files_on_identity_file_id", using: :btree
  add_index "blood_test_files", ["identity_id"], name: "index_blood_test_files_on_identity_id", using: :btree

  create_table "blood_test_results", force: :cascade do |t|
    t.integer  "blood_test_id"
    t.integer  "blood_concentration_id"
    t.decimal  "concentration",          precision: 10, scale: 2
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "blood_test_results", ["blood_concentration_id"], name: "index_blood_test_results_on_blood_concentration_id", using: :btree
  add_index "blood_test_results", ["blood_test_id"], name: "index_blood_test_results_on_blood_test_id", using: :btree
  add_index "blood_test_results", ["identity_id"], name: "index_blood_test_results_on_identity_id", using: :btree

  create_table "blood_tests", force: :cascade do |t|
    t.datetime "fast_started"
    t.datetime "test_time"
    t.text     "notes"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.integer  "doctor_id"
    t.integer  "location_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "blood_tests", ["doctor_id"], name: "index_blood_tests_on_doctor_id", using: :btree
  add_index "blood_tests", ["identity_id"], name: "index_blood_tests_on_identity_id", using: :btree
  add_index "blood_tests", ["location_id"], name: "index_blood_tests_on_location_id", using: :btree

  create_table "book_quotes", force: :cascade do |t|
    t.integer  "book_id"
    t.text     "book_quote"
    t.string   "pages"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "book_quotes", ["book_id"], name: "index_book_quotes_on_book_id", using: :btree
  add_index "book_quotes", ["identity_id"], name: "index_book_quotes_on_identity_id", using: :btree

  create_table "book_stores", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "rating"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
  end

  add_index "book_stores", ["identity_id"], name: "index_book_stores_on_identity_id", using: :btree
  add_index "book_stores", ["location_id"], name: "index_book_stores_on_location_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "book_name",        limit: 255
    t.string   "isbn",             limit: 255
    t.string   "author",           limit: 255
    t.datetime "when_read"
    t.integer  "identity_id"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.integer  "recommender_id"
    t.text     "review"
    t.integer  "lent_to_id"
    t.date     "lent_date"
    t.integer  "borrowed_from_id"
    t.date     "borrowed_date"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "books", ["borrowed_from_id"], name: "index_books_on_borrowed_from_id", using: :btree
  add_index "books", ["identity_id"], name: "index_books_on_identity_id", using: :btree
  add_index "books", ["lent_to_id"], name: "index_books_on_lent_to_id", using: :btree
  add_index "books", ["recommender_id"], name: "index_books_on_recommender_id", using: :btree

  create_table "business_card_files", force: :cascade do |t|
    t.integer  "business_card_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.integer  "position"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "business_card_files", ["business_card_id"], name: "index_business_card_files_on_business_card_id", using: :btree
  add_index "business_card_files", ["identity_file_id"], name: "index_business_card_files_on_identity_file_id", using: :btree
  add_index "business_card_files", ["identity_id"], name: "index_business_card_files_on_identity_id", using: :btree

  create_table "business_cards", force: :cascade do |t|
    t.integer  "contact_id"
    t.text     "notes"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "business_cards", ["contact_id"], name: "index_business_cards_on_contact_id", using: :btree
  add_index "business_cards", ["identity_id"], name: "index_business_cards_on_identity_id", using: :btree

  create_table "cafes", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "rating"
    t.text     "notes"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
  end

  add_index "cafes", ["identity_id"], name: "index_cafes_on_identity_id", using: :btree
  add_index "cafes", ["location_id"], name: "index_cafes_on_location_id", using: :btree

  create_table "calculation_elements", force: :cascade do |t|
    t.integer  "left_operand_id"
    t.integer  "right_operand_id"
    t.integer  "operator"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "identity_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "calculation_elements", ["identity_id"], name: "index_calculation_elements_on_identity_id", using: :btree
  add_index "calculation_elements", ["left_operand_id"], name: "index_calculation_elements_on_left_operand_id", using: :btree
  add_index "calculation_elements", ["right_operand_id"], name: "index_calculation_elements_on_right_operand_id", using: :btree

  create_table "calculation_forms", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "root_element_id"
    t.text     "equation"
    t.boolean  "is_duplicate"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "calculation_forms", ["identity_id"], name: "index_calculation_forms_on_identity_id", using: :btree
  add_index "calculation_forms", ["root_element_id"], name: "index_calculation_forms_on_root_element_id", using: :btree

  create_table "calculation_inputs", force: :cascade do |t|
    t.string   "input_name",          limit: 255
    t.string   "input_value",         limit: 255
    t.integer  "calculation_form_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "variable_name",       limit: 255
    t.integer  "identity_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "calculation_inputs", ["calculation_form_id"], name: "index_calculation_inputs_on_calculation_form_id", using: :btree
  add_index "calculation_inputs", ["identity_id"], name: "index_calculation_inputs_on_identity_id", using: :btree

  create_table "calculation_operands", force: :cascade do |t|
    t.string   "constant_value",         limit: 255
    t.integer  "calculation_element_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "calculation_input_id"
    t.integer  "identity_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "calculation_operands", ["calculation_element_id"], name: "index_calculation_operands_on_calculation_element_id", using: :btree
  add_index "calculation_operands", ["identity_id"], name: "index_calculation_operands_on_identity_id", using: :btree

  create_table "calculations", force: :cascade do |t|
    t.string   "name",                         limit: 255
    t.integer  "calculation_form_id"
    t.decimal  "result",                                   precision: 10, scale: 2
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "original_calculation_form_id"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "calculations", ["calculation_form_id"], name: "index_calculations_on_calculation_form_id", using: :btree
  add_index "calculations", ["identity_id"], name: "index_calculations_on_identity_id", using: :btree

  create_table "calendar_item_reminder_pendings", force: :cascade do |t|
    t.integer  "calendar_item_reminder_id"
    t.integer  "identity_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "calendar_id"
    t.integer  "calendar_item_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "calendar_item_reminder_pendings", ["calendar_id"], name: "index_calendar_item_reminder_pendings_on_calendar_id", using: :btree
  add_index "calendar_item_reminder_pendings", ["calendar_item_id"], name: "index_calendar_item_reminder_pendings_on_calendar_item_id", using: :btree
  add_index "calendar_item_reminder_pendings", ["calendar_item_reminder_id"], name: "index_calendar_item_reminder_pendings_on_cir_id", using: :btree
  add_index "calendar_item_reminder_pendings", ["identity_id"], name: "index_calendar_item_reminder_pendings_on_identity_id", using: :btree

  create_table "calendar_item_reminders", force: :cascade do |t|
    t.integer  "threshold_amount"
    t.integer  "threshold_type"
    t.integer  "repeat_amount"
    t.integer  "repeat_type"
    t.integer  "expire_amount"
    t.integer  "expire_type"
    t.integer  "calendar_item_id"
    t.integer  "identity_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "max_pending"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "calendar_item_reminders", ["calendar_item_id"], name: "index_calendar_item_reminders_on_calendar_item_id", using: :btree
  add_index "calendar_item_reminders", ["identity_id"], name: "index_calendar_item_reminders_on_identity_id", using: :btree

  create_table "calendar_items", force: :cascade do |t|
    t.integer  "calendar_id"
    t.datetime "calendar_item_time"
    t.text     "notes"
    t.boolean  "persistent"
    t.integer  "repeat_amount"
    t.integer  "repeat_type"
    t.string   "model_class"
    t.integer  "model_id"
    t.integer  "identity_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "context_info"
    t.boolean  "is_repeat"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "calendar_items", ["calendar_id"], name: "index_calendar_items_on_calendar_id", using: :btree
  add_index "calendar_items", ["identity_id"], name: "index_calendar_items_on_identity_id", using: :btree

  create_table "calendars", force: :cascade do |t|
    t.boolean  "trash"
    t.integer  "identity_id"
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
    t.integer  "reminder_repeat_amount"
    t.integer  "reminder_repeat_type"
    t.integer  "general_threshold"
    t.integer  "happy_things_threshold"
    t.integer  "website_domain_registration_threshold"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "calendars", ["identity_id"], name: "index_calendars_on_identity_id", using: :btree

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
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.boolean  "boondocking"
    t.boolean  "cell_phone_reception"
    t.boolean  "cell_phone_data"
    t.integer  "membership_id"
    t.datetime "archived"
  end

  add_index "camp_locations", ["identity_id"], name: "index_camp_locations_on_identity_id", using: :btree
  add_index "camp_locations", ["location_id"], name: "index_camp_locations_on_location_id", using: :btree
  add_index "camp_locations", ["membership_id"], name: "index_camp_locations_on_membership_id", using: :btree

  create_table "cashbacks", force: :cascade do |t|
    t.integer  "identity_id"
    t.decimal  "cashback_percentage",             precision: 10, scale: 2
    t.string   "applies_to",          limit: 255
    t.date     "start_date"
    t.date     "end_date"
    t.decimal  "yearly_maximum",                  precision: 10, scale: 2
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "default_cashback"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "cashbacks", ["identity_id"], name: "index_cashbacks_on_identity_id", using: :btree

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
    t.boolean  "experimental"
    t.boolean  "simple"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree
  add_index "categories", ["parent_id"], name: "index_categories_on_parent_id", using: :btree

  create_table "category_points_amounts", force: :cascade do |t|
    t.integer  "identity_id"
    t.integer  "category_id"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visits"
    t.datetime "last_visit"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "category_points_amounts", ["category_id"], name: "index_category_points_amounts_on_category_id", using: :btree
  add_index "category_points_amounts", ["identity_id"], name: "index_category_points_amounts_on_identity_id", using: :btree

  create_table "charities", force: :cascade do |t|
    t.integer  "location_id"
    t.text     "notes"
    t.integer  "rating"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
  end

  add_index "charities", ["identity_id"], name: "index_charities_on_identity_id", using: :btree
  add_index "charities", ["location_id"], name: "index_charities_on_location_id", using: :btree

  create_table "checklist_items", force: :cascade do |t|
    t.string   "checklist_item_name", limit: 255
    t.integer  "checklist_id"
    t.integer  "position"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "checklist_items", ["checklist_id"], name: "index_checklist_items_on_checklist_id", using: :btree
  add_index "checklist_items", ["identity_id"], name: "index_checklist_items_on_identity_id", using: :btree

  create_table "checklist_references", force: :cascade do |t|
    t.integer  "checklist_parent_id"
    t.integer  "checklist_id"
    t.integer  "identity_id"
    t.boolean  "pre_checklist"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "checklist_references", ["checklist_id"], name: "index_checklist_references_on_checklist_id", using: :btree
  add_index "checklist_references", ["checklist_parent_id"], name: "index_checklist_references_on_checklist_parent_id", using: :btree
  add_index "checklist_references", ["identity_id"], name: "index_checklist_references_on_identity_id", using: :btree

  create_table "checklists", force: :cascade do |t|
    t.string   "checklist_name", limit: 255
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "checklists", ["identity_id"], name: "index_checklists_on_identity_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.integer  "identity_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",        limit: 255
    t.text     "notes"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "companies", ["identity_id"], name: "index_companies_on_identity_id", using: :btree
  add_index "companies", ["location_id"], name: "index_companies_on_location_id", using: :btree

  create_table "complete_due_items", force: :cascade do |t|
    t.integer  "identity_id"
    t.string   "display",           limit: 255
    t.string   "link",              limit: 255
    t.datetime "due_date"
    t.string   "myp_model_name",    limit: 255
    t.integer  "model_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "original_due_date"
    t.integer  "calendar_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "complete_due_items", ["calendar_id"], name: "index_complete_due_items_on_calendar_id", using: :btree
  add_index "complete_due_items", ["identity_id"], name: "index_complete_due_items_on_identity_id", using: :btree

  create_table "computer_ssh_keys", force: :cascade do |t|
    t.integer  "computer_id"
    t.integer  "ssh_key_id"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "username"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "computer_ssh_keys", ["computer_id"], name: "index_computer_ssh_keys_on_computer_id", using: :btree
  add_index "computer_ssh_keys", ["identity_id"], name: "index_computer_ssh_keys_on_identity_id", using: :btree
  add_index "computer_ssh_keys", ["ssh_key_id"], name: "index_computer_ssh_keys_on_ssh_key_id", using: :btree

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
    t.integer  "identity_id"
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
    t.string   "hostname"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "computers", ["administrator_id"], name: "index_computers_on_administrator_id", using: :btree
  add_index "computers", ["identity_id"], name: "index_computers_on_identity_id", using: :btree
  add_index "computers", ["main_user_id"], name: "index_computers_on_main_user_id", using: :btree
  add_index "computers", ["manufacturer_id"], name: "index_computers_on_manufacturer_id", using: :btree

  create_table "concert_musical_groups", force: :cascade do |t|
    t.integer  "identity_id"
    t.integer  "concert_id"
    t.integer  "musical_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "concert_musical_groups", ["concert_id"], name: "index_concert_musical_groups_on_concert_id", using: :btree
  add_index "concert_musical_groups", ["identity_id"], name: "index_concert_musical_groups_on_identity_id", using: :btree
  add_index "concert_musical_groups", ["musical_group_id"], name: "index_concert_musical_groups_on_musical_group_id", using: :btree

  create_table "concert_pictures", force: :cascade do |t|
    t.integer  "concert_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "concert_pictures", ["concert_id"], name: "index_concert_pictures_on_concert_id", using: :btree
  add_index "concert_pictures", ["identity_file_id"], name: "index_concert_pictures_on_identity_file_id", using: :btree
  add_index "concert_pictures", ["identity_id"], name: "index_concert_pictures_on_identity_id", using: :btree

  create_table "concerts", force: :cascade do |t|
    t.string   "concert_date",  limit: 255
    t.string   "concert_title", limit: 255
    t.integer  "location_id"
    t.text     "notes"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "concerts", ["identity_id"], name: "index_concerts_on_identity_id", using: :btree
  add_index "concerts", ["location_id"], name: "index_concerts_on_location_id", using: :btree

  create_table "connections", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "connection_status"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "connection_request_token"
    t.integer  "contact_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "connections", ["contact_id"], name: "index_connections_on_contact_id", using: :btree
  add_index "connections", ["identity_id"], name: "index_connections_on_identity_id", using: :btree
  add_index "connections", ["user_id"], name: "index_connections_on_user_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.integer  "contact_identity_id"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contact_type"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "contacts", ["contact_identity_id"], name: "index_contacts_on_contact_identity_id", using: :btree
  add_index "contacts", ["identity_id"], name: "index_contacts_on_identity_id", using: :btree

  create_table "conversations", force: :cascade do |t|
    t.integer  "contact_id"
    t.text     "conversation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "conversation_date"
    t.integer  "identity_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "conversations", ["contact_id"], name: "index_conversations_on_contact_id", using: :btree
  add_index "conversations", ["identity_id"], name: "index_conversations_on_identity_id", using: :btree

  create_table "credit_card_cashbacks", force: :cascade do |t|
    t.integer  "identity_id"
    t.integer  "credit_card_id"
    t.integer  "cashback_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "credit_card_cashbacks", ["cashback_id"], name: "index_credit_card_cashbacks_on_cashback_id", using: :btree
  add_index "credit_card_cashbacks", ["credit_card_id"], name: "index_credit_card_cashbacks_on_credit_card_id", using: :btree
  add_index "credit_card_cashbacks", ["identity_id"], name: "index_credit_card_cashbacks_on_identity_id", using: :btree

  create_table "credit_cards", force: :cascade do |t|
    t.string   "name",                       limit: 255
    t.string   "number",                     limit: 255
    t.date     "expires"
    t.string   "security_code",              limit: 255
    t.integer  "password_id"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pin",                        limit: 255
    t.text     "notes"
    t.integer  "address_id"
    t.integer  "number_encrypted_id"
    t.integer  "security_code_encrypted_id"
    t.integer  "pin_encrypted_id"
    t.integer  "expires_encrypted_id"
    t.datetime "archived"
    t.integer  "card_type"
    t.decimal  "total_credit",                           precision: 10, scale: 2
    t.integer  "visit_count"
    t.boolean  "email_reminders"
    t.integer  "rating"
  end

  add_index "credit_cards", ["address_id"], name: "index_credit_cards_on_address_id", using: :btree
  add_index "credit_cards", ["expires_encrypted_id"], name: "index_credit_cards_on_expires_encrypted_id", using: :btree
  add_index "credit_cards", ["identity_id"], name: "index_credit_cards_on_identity_id", using: :btree
  add_index "credit_cards", ["number_encrypted_id"], name: "index_credit_cards_on_number_encrypted_id", using: :btree
  add_index "credit_cards", ["password_id"], name: "index_credit_cards_on_password_id", using: :btree
  add_index "credit_cards", ["pin_encrypted_id"], name: "index_credit_cards_on_pin_encrypted_id", using: :btree
  add_index "credit_cards", ["security_code_encrypted_id"], name: "index_credit_cards_on_security_code_encrypted_id", using: :btree

  create_table "credit_scores", force: :cascade do |t|
    t.date     "score_date"
    t.integer  "score"
    t.string   "source",      limit: 255
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "credit_scores", ["identity_id"], name: "index_credit_scores_on_identity_id", using: :btree

  create_table "date_locations", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "date_locations", ["identity_id"], name: "index_date_locations_on_identity_id", using: :btree
  add_index "date_locations", ["location_id"], name: "index_date_locations_on_location_id", using: :btree

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
    t.boolean  "archived"
    t.integer  "periodic_payment_id"
    t.text     "notes"
    t.integer  "group_company_id"
    t.integer  "password_id"
    t.string   "account_number",       limit: 255
    t.string   "group_number",         limit: 255
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "doctor_id"
    t.integer  "visit_count"
    t.integer  "rating"
  end

  add_index "dental_insurances", ["doctor_id"], name: "index_dental_insurances_on_doctor_id", using: :btree
  add_index "dental_insurances", ["group_company_id"], name: "index_dental_insurances_on_group_company_id", using: :btree
  add_index "dental_insurances", ["identity_id"], name: "index_dental_insurances_on_identity_id", using: :btree
  add_index "dental_insurances", ["insurance_company_id"], name: "index_dental_insurances_on_insurance_company_id", using: :btree
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
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "dentist_visits", ["dental_insurance_id"], name: "index_dentist_visits_on_dental_insurance_id", using: :btree
  add_index "dentist_visits", ["dentist_id"], name: "index_dentist_visits_on_dentist_id", using: :btree
  add_index "dentist_visits", ["identity_id"], name: "index_dentist_visits_on_identity_id", using: :btree

  create_table "desired_locations", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "website_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "desired_locations", ["identity_id"], name: "index_desired_locations_on_identity_id", using: :btree
  add_index "desired_locations", ["location_id"], name: "index_desired_locations_on_location_id", using: :btree
  add_index "desired_locations", ["website_id"], name: "index_desired_locations_on_website_id", using: :btree

  create_table "desired_products", force: :cascade do |t|
    t.string   "product_name", limit: 255
    t.text     "notes"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "desired_products", ["identity_id"], name: "index_desired_products_on_identity_id", using: :btree

  create_table "dessert_locations", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "rating"
    t.text     "notes"
    t.boolean  "visited"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
  end

  add_index "dessert_locations", ["identity_id"], name: "index_dessert_locations_on_identity_id", using: :btree
  add_index "dessert_locations", ["location_id"], name: "index_dessert_locations_on_location_id", using: :btree

  create_table "diary_entries", force: :cascade do |t|
    t.datetime "diary_time"
    t.text     "entry"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "diary_title",        limit: 255
    t.integer  "visit_count"
    t.integer  "entry_encrypted_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "diary_entries", ["entry_encrypted_id"], name: "index_diary_entries_on_entry_encrypted_id", using: :btree
  add_index "diary_entries", ["identity_id"], name: "index_diary_entries_on_identity_id", using: :btree

  create_table "doctor_visits", force: :cascade do |t|
    t.date     "visit_date"
    t.text     "notes"
    t.integer  "doctor_id"
    t.integer  "health_insurance_id"
    t.decimal  "paid",                precision: 10, scale: 2
    t.boolean  "physical"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "doctor_visits", ["doctor_id"], name: "index_doctor_visits_on_doctor_id", using: :btree
  add_index "doctor_visits", ["health_insurance_id"], name: "index_doctor_visits_on_health_insurance_id", using: :btree
  add_index "doctor_visits", ["identity_id"], name: "index_doctor_visits_on_identity_id", using: :btree

  create_table "doctors", force: :cascade do |t|
    t.integer  "contact_id"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "doctor_type"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "doctors", ["contact_id"], name: "index_doctors_on_contact_id", using: :btree
  add_index "doctors", ["identity_id"], name: "index_doctors_on_identity_id", using: :btree

  create_table "drafts", force: :cascade do |t|
    t.string   "draft_name"
    t.text     "notes"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "drafts", ["identity_id"], name: "index_drafts_on_identity_id", using: :btree

  create_table "dreams", force: :cascade do |t|
    t.string   "dream_name"
    t.datetime "dream_time"
    t.text     "dream"
    t.integer  "dream_encrypted_id"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "dream_encrypted_id_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "dreams", ["dream_encrypted_id"], name: "index_dreams_on_dream_encrypted_id", using: :btree
  add_index "dreams", ["dream_encrypted_id_id"], name: "index_dreams_on_dream_encrypted_id_id", using: :btree
  add_index "dreams", ["identity_id"], name: "index_dreams_on_identity_id", using: :btree

  create_table "drinks", force: :cascade do |t|
    t.integer  "identity_id"
    t.string   "drink_name",  limit: 255
    t.text     "notes"
    t.decimal  "calories",                precision: 10, scale: 2
    t.decimal  "price",                   precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "drinks", ["identity_id"], name: "index_drinks_on_identity_id", using: :btree

  create_table "due_items", force: :cascade do |t|
    t.string   "display",           limit: 255
    t.string   "link",              limit: 255
    t.datetime "due_date"
    t.string   "myp_model_name",    limit: 255
    t.integer  "model_id"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "original_due_date"
    t.boolean  "is_date_arbitrary"
    t.integer  "calendar_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "due_items", ["calendar_id"], name: "index_due_items_on_calendar_id", using: :btree
  add_index "due_items", ["identity_id"], name: "index_due_items_on_identity_id", using: :btree

  create_table "education_files", force: :cascade do |t|
    t.integer  "education_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.integer  "position"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "education_files", ["education_id"], name: "index_education_files_on_education_id", using: :btree
  add_index "education_files", ["identity_file_id"], name: "index_education_files_on_identity_file_id", using: :btree
  add_index "education_files", ["identity_id"], name: "index_education_files_on_identity_id", using: :btree

  create_table "educations", force: :cascade do |t|
    t.string   "education_name"
    t.date     "education_start"
    t.date     "education_end"
    t.decimal  "gpa",             precision: 10, scale: 2
    t.integer  "location_id"
    t.text     "notes"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
    t.string   "degree_name"
    t.integer  "identity_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "degree_type"
    t.datetime "graduated"
    t.string   "student_id"
  end

  add_index "educations", ["identity_id"], name: "index_educations_on_identity_id", using: :btree
  add_index "educations", ["location_id"], name: "index_educations_on_location_id", using: :btree

  create_table "email_contacts", force: :cascade do |t|
    t.integer  "email_id"
    t.integer  "identity_id"
    t.integer  "contact_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "email_contacts", ["contact_id"], name: "index_email_contacts_on_contact_id", using: :btree
  add_index "email_contacts", ["email_id"], name: "index_email_contacts_on_email_id", using: :btree
  add_index "email_contacts", ["identity_id"], name: "index_email_contacts_on_identity_id", using: :btree

  create_table "email_groups", force: :cascade do |t|
    t.integer  "email_id"
    t.integer  "group_id"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "email_groups", ["email_id"], name: "index_email_groups_on_email_id", using: :btree
  add_index "email_groups", ["group_id"], name: "index_email_groups_on_group_id", using: :btree
  add_index "email_groups", ["identity_id"], name: "index_email_groups_on_identity_id", using: :btree

  create_table "email_personalizations", force: :cascade do |t|
    t.string   "target"
    t.text     "additional_text"
    t.boolean  "do_send"
    t.integer  "identity_id"
    t.integer  "email_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "email_personalizations", ["email_id"], name: "index_email_personalizations_on_email_id", using: :btree
  add_index "email_personalizations", ["identity_id"], name: "index_email_personalizations_on_identity_id", using: :btree

  create_table "email_tokens", force: :cascade do |t|
    t.string   "email"
    t.string   "token"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "identity_id"
  end

  add_index "email_tokens", ["identity_id"], name: "index_email_tokens_on_identity_id", using: :btree

  create_table "email_unsubscriptions", force: :cascade do |t|
    t.string   "email"
    t.string   "category"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "identity_id"
  end

  add_index "email_unsubscriptions", ["identity_id"], name: "index_email_unsubscriptions_on_identity_id", using: :btree

  create_table "emails", force: :cascade do |t|
    t.string   "subject"
    t.text     "body"
    t.boolean  "copy_self"
    t.string   "email_category"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "use_bcc"
    t.boolean  "draft"
    t.boolean  "personalize"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "emails", ["identity_id"], name: "index_emails_on_identity_id", using: :btree

  create_table "emergency_contacts", force: :cascade do |t|
    t.integer  "email_id"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "emergency_contacts", ["email_id"], name: "index_emergency_contacts_on_email_id", using: :btree
  add_index "emergency_contacts", ["identity_id"], name: "index_emergency_contacts_on_identity_id", using: :btree

  create_table "encrypted_values", force: :cascade do |t|
    t.binary   "val"
    t.binary   "salt"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "encryption_type"
  end

  add_index "encrypted_values", ["user_id"], name: "index_encrypted_values_on_user_id", using: :btree

  create_table "event_contacts", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "contact_id"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "event_contacts", ["contact_id"], name: "index_event_contacts_on_contact_id", using: :btree
  add_index "event_contacts", ["event_id"], name: "index_event_contacts_on_event_id", using: :btree
  add_index "event_contacts", ["identity_id"], name: "index_event_contacts_on_identity_id", using: :btree

  create_table "event_pictures", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "position"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "event_pictures", ["event_id"], name: "index_event_pictures_on_event_id", using: :btree
  add_index "event_pictures", ["identity_file_id"], name: "index_event_pictures_on_identity_file_id", using: :btree
  add_index "event_pictures", ["identity_id"], name: "index_event_pictures_on_identity_id", using: :btree

  create_table "event_rsvps", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "identity_id"
    t.integer  "rsvp_type"
    t.string   "email"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "event_rsvps", ["event_id"], name: "index_event_rsvps_on_event_id", using: :btree
  add_index "event_rsvps", ["identity_id"], name: "index_event_rsvps_on_identity_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "event_name",     limit: 255
    t.text     "notes"
    t.datetime "event_time"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.integer  "repeat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "event_end_time"
    t.integer  "location_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "events", ["identity_id"], name: "index_events_on_identity_id", using: :btree
  add_index "events", ["location_id"], name: "index_events_on_location_id", using: :btree
  add_index "events", ["repeat_id"], name: "index_events_on_repeat_id", using: :btree

  create_table "exercise_regimen_exercise_files", force: :cascade do |t|
    t.integer  "exercise_regimen_exercise_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.integer  "position"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "exercise_regimen_exercise_files", ["exercise_regimen_exercise_id"], name: "eref_on_erei", using: :btree
  add_index "exercise_regimen_exercise_files", ["identity_file_id"], name: "index_exercise_regimen_exercise_files_on_identity_file_id", using: :btree
  add_index "exercise_regimen_exercise_files", ["identity_id"], name: "index_exercise_regimen_exercise_files_on_identity_id", using: :btree

  create_table "exercise_regimen_exercises", force: :cascade do |t|
    t.string   "exercise_regimen_exercise_name"
    t.text     "notes"
    t.integer  "position"
    t.integer  "exercise_regimen_id"
    t.integer  "identity_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "exercise_regimen_exercises", ["exercise_regimen_id"], name: "index_exercise_regimen_exercises_on_exercise_regimen_id", using: :btree
  add_index "exercise_regimen_exercises", ["identity_id"], name: "index_exercise_regimen_exercises_on_identity_id", using: :btree

  create_table "exercise_regimens", force: :cascade do |t|
    t.string   "exercise_regimen_name"
    t.text     "notes"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "exercise_regimens", ["identity_id"], name: "index_exercise_regimens_on_identity_id", using: :btree

  create_table "exercises", force: :cascade do |t|
    t.datetime "exercise_start"
    t.datetime "exercise_end"
    t.string   "exercise_activity", limit: 255
    t.text     "notes"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "situps"
    t.integer  "pushups"
    t.integer  "cardio_time"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "exercises", ["identity_id"], name: "index_exercises_on_identity_id", using: :btree

  create_table "favorite_locations", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "favorite_locations", ["identity_id"], name: "index_favorite_locations_on_identity_id", using: :btree
  add_index "favorite_locations", ["location_id"], name: "index_favorite_locations_on_location_id", using: :btree

  create_table "favorite_product_files", force: :cascade do |t|
    t.integer  "favorite_product_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.integer  "position"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "favorite_product_files", ["favorite_product_id"], name: "index_favorite_product_files_on_favorite_product_id", using: :btree
  add_index "favorite_product_files", ["identity_file_id"], name: "index_favorite_product_files_on_identity_file_id", using: :btree
  add_index "favorite_product_files", ["identity_id"], name: "index_favorite_product_files_on_identity_id", using: :btree

  create_table "favorite_product_links", force: :cascade do |t|
    t.integer  "favorite_product_id"
    t.integer  "identity_id"
    t.string   "link",                limit: 2000
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "favorite_product_links", ["favorite_product_id"], name: "index_favorite_product_links_on_favorite_product_id", using: :btree
  add_index "favorite_product_links", ["identity_id"], name: "index_favorite_product_links_on_identity_id", using: :btree

  create_table "favorite_products", force: :cascade do |t|
    t.string   "product_name", limit: 255
    t.text     "notes"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "favorite_products", ["identity_id"], name: "index_favorite_products_on_identity_id", using: :btree

  create_table "feed_items", force: :cascade do |t|
    t.string   "feed_title"
    t.integer  "feed_id"
    t.string   "feed_link"
    t.text     "content"
    t.datetime "publication_date"
    t.string   "guid"
    t.integer  "identity_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "read"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "feed_items", ["feed_id"], name: "index_feed_items_on_feed_id", using: :btree
  add_index "feed_items", ["identity_id"], name: "index_feed_items_on_identity_id", using: :btree

  create_table "feed_load_statuses", force: :cascade do |t|
    t.integer  "items_total"
    t.integer  "items_complete"
    t.integer  "identity_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "items_error"
  end

  add_index "feed_load_statuses", ["identity_id"], name: "index_feed_load_statuses_on_identity_id", using: :btree

  create_table "feeds", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "url",         limit: 255
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "feeds", ["identity_id"], name: "index_feeds_on_identity_id", using: :btree

  create_table "files", force: :cascade do |t|
    t.integer "identity_file_id"
    t.string  "style",            limit: 255
    t.binary  "file_contents"
    t.integer "visit_count"
  end

  create_table "flight_legs", force: :cascade do |t|
    t.integer  "flight_id"
    t.integer  "flight_number"
    t.integer  "flight_company_id"
    t.string   "depart_airport_code"
    t.integer  "depart_location_id"
    t.datetime "depart_time"
    t.string   "arrival_airport_code"
    t.integer  "arrival_location_id"
    t.datetime "arrive_time"
    t.string   "seat_number"
    t.integer  "position"
    t.integer  "identity_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "flight_legs", ["arrival_location_id"], name: "index_flight_legs_on_arrival_location_id", using: :btree
  add_index "flight_legs", ["depart_location_id"], name: "index_flight_legs_on_depart_location_id", using: :btree
  add_index "flight_legs", ["flight_company_id"], name: "index_flight_legs_on_flight_company_id", using: :btree
  add_index "flight_legs", ["flight_id"], name: "index_flight_legs_on_flight_id", using: :btree
  add_index "flight_legs", ["identity_id"], name: "index_flight_legs_on_identity_id", using: :btree

  create_table "flights", force: :cascade do |t|
    t.string   "flight_name"
    t.date     "flight_start_date"
    t.string   "confirmation_number"
    t.integer  "visit_count"
    t.text     "notes"
    t.integer  "identity_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "flights", ["identity_id"], name: "index_flights_on_identity_id", using: :btree

  create_table "food_ingredients", force: :cascade do |t|
    t.integer  "identity_id"
    t.integer  "parent_food_id"
    t.integer  "food_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "food_ingredients", ["food_id"], name: "index_food_ingredients_on_food_id", using: :btree
  add_index "food_ingredients", ["identity_id"], name: "index_food_ingredients_on_identity_id", using: :btree
  add_index "food_ingredients", ["parent_food_id"], name: "index_food_ingredients_on_parent_food_id", using: :btree

  create_table "foods", force: :cascade do |t|
    t.integer  "identity_id"
    t.string   "food_name",   limit: 255
    t.text     "notes"
    t.decimal  "calories",                precision: 10, scale: 2
    t.decimal  "price",                   precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "weight_type"
    t.decimal  "weight",                  precision: 10, scale: 2
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "foods", ["identity_id"], name: "index_foods_on_identity_id", using: :btree

  create_table "gas_stations", force: :cascade do |t|
    t.integer  "location_id"
    t.boolean  "gas"
    t.boolean  "diesel"
    t.boolean  "propane_replacement"
    t.boolean  "propane_fillup"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "gas_stations", ["identity_id"], name: "index_gas_stations_on_identity_id", using: :btree
  add_index "gas_stations", ["location_id"], name: "index_gas_stations_on_location_id", using: :btree

  create_table "group_contacts", force: :cascade do |t|
    t.integer  "identity_id"
    t.integer  "group_id"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "group_contacts", ["contact_id"], name: "index_group_contacts_on_contact_id", using: :btree
  add_index "group_contacts", ["group_id"], name: "index_group_contacts_on_group_id", using: :btree
  add_index "group_contacts", ["identity_id"], name: "index_group_contacts_on_identity_id", using: :btree

  create_table "group_references", force: :cascade do |t|
    t.integer  "identity_id"
    t.integer  "parent_group_id"
    t.integer  "group_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "group_references", ["group_id"], name: "index_group_references_on_group_id", using: :btree
  add_index "group_references", ["identity_id"], name: "index_group_references_on_identity_id", using: :btree
  add_index "group_references", ["parent_group_id"], name: "index_group_references_on_parent_group_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "group_name",  limit: 255
    t.text     "notes"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "groups", ["identity_id"], name: "index_groups_on_identity_id", using: :btree

  create_table "gun_registrations", force: :cascade do |t|
    t.integer  "location_id"
    t.date     "registered"
    t.date     "expires"
    t.integer  "gun_id"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "gun_registrations", ["gun_id"], name: "index_gun_registrations_on_gun_id", using: :btree
  add_index "gun_registrations", ["identity_id"], name: "index_gun_registrations_on_identity_id", using: :btree
  add_index "gun_registrations", ["location_id"], name: "index_gun_registrations_on_location_id", using: :btree

  create_table "guns", force: :cascade do |t|
    t.string   "gun_name",          limit: 255
    t.string   "manufacturer_name", limit: 255
    t.string   "gun_model",         limit: 255
    t.decimal  "bullet_caliber",                precision: 10, scale: 2
    t.integer  "max_bullets"
    t.decimal  "price",                         precision: 10, scale: 2
    t.date     "purchased"
    t.text     "notes"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "guns", ["identity_id"], name: "index_guns_on_identity_id", using: :btree

  create_table "happy_things", force: :cascade do |t|
    t.string   "happy_thing_name"
    t.text     "notes"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "happy_things", ["identity_id"], name: "index_happy_things_on_identity_id", using: :btree

  create_table "headaches", force: :cascade do |t|
    t.datetime "started"
    t.datetime "ended"
    t.integer  "intensity"
    t.string   "headache_location", limit: 255
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "headaches", ["identity_id"], name: "index_headaches_on_identity_id", using: :btree

  create_table "health_insurances", force: :cascade do |t|
    t.string   "insurance_name",       limit: 255
    t.integer  "insurance_company_id"
    t.datetime "archived"
    t.integer  "periodic_payment_id"
    t.text     "notes"
    t.integer  "group_company_id"
    t.integer  "password_id"
    t.string   "account_number",       limit: 255
    t.string   "group_number",         limit: 255
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "doctor_id"
    t.integer  "visit_count"
    t.integer  "rating"
  end

  add_index "health_insurances", ["doctor_id"], name: "index_health_insurances_on_doctor_id", using: :btree
  add_index "health_insurances", ["group_company_id"], name: "index_health_insurances_on_group_company_id", using: :btree
  add_index "health_insurances", ["identity_id"], name: "index_health_insurances_on_identity_id", using: :btree
  add_index "health_insurances", ["insurance_company_id"], name: "index_health_insurances_on_insurance_company_id", using: :btree
  add_index "health_insurances", ["password_id"], name: "index_health_insurances_on_password_id", using: :btree
  add_index "health_insurances", ["periodic_payment_id"], name: "index_health_insurances_on_periodic_payment_id", using: :btree

  create_table "heart_rates", force: :cascade do |t|
    t.integer  "beats"
    t.date     "measurement_date"
    t.string   "measurement_source", limit: 255
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "heart_rates", ["identity_id"], name: "index_heart_rates_on_identity_id", using: :btree

  create_table "heights", force: :cascade do |t|
    t.decimal  "height_amount",                  precision: 10, scale: 2
    t.integer  "amount_type"
    t.date     "measurement_date"
    t.string   "measurement_source", limit: 255
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "heights", ["identity_id"], name: "index_heights_on_identity_id", using: :btree

  create_table "hobbies", force: :cascade do |t|
    t.string   "hobby_name",  limit: 255
    t.text     "notes"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "hobbies", ["identity_id"], name: "index_hobbies_on_identity_id", using: :btree

  create_table "hotels", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "breakfast_rating"
    t.integer  "overall_rating"
    t.text     "notes"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "room_number"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "hotels", ["identity_id"], name: "index_hotels_on_identity_id", using: :btree
  add_index "hotels", ["location_id"], name: "index_hotels_on_location_id", using: :btree

  create_table "hypotheses", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "notes"
    t.integer  "question_id"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "hypotheses", ["identity_id"], name: "index_hypotheses_on_identity_id", using: :btree
  add_index "hypotheses", ["question_id"], name: "index_hypotheses_on_question_id", using: :btree

  create_table "hypothesis_experiments", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.text     "notes"
    t.date     "started"
    t.date     "ended"
    t.integer  "hypothesis_id"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "hypothesis_experiments", ["hypothesis_id"], name: "index_hypothesis_experiments_on_hypothesis_id", using: :btree
  add_index "hypothesis_experiments", ["identity_id"], name: "index_hypothesis_experiments_on_identity_id", using: :btree

  create_table "ideas", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "idea"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "ideas", ["identity_id"], name: "index_ideas_on_identity_id", using: :btree

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
    t.integer  "sex_type"
    t.integer  "company_id"
    t.string   "middle_name"
    t.string   "last_name"
    t.integer  "identity_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "identities", ["company_id"], name: "index_identities_on_company_id", using: :btree
  add_index "identities", ["identity_id"], name: "index_identities_on_identity_id", using: :btree
  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "identity_drivers_licenses", force: :cascade do |t|
    t.string   "identifier",         limit: 255
    t.string   "region",             limit: 255
    t.string   "sub_region1",        limit: 255
    t.date     "expires"
    t.integer  "parent_identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "identity_drivers_licenses", ["parent_identity_id"], name: "index_identity_drivers_licenses_on_parent_identity_id", using: :btree

  create_table "identity_emails", force: :cascade do |t|
    t.string   "email",              limit: 255
    t.integer  "parent_identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "identity_id"
    t.boolean  "secondary"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "identity_emails", ["identity_id"], name: "index_identity_emails_on_identity_id", using: :btree
  add_index "identity_emails", ["parent_identity_id"], name: "index_identity_emails_on_parent_identity_id", using: :btree

  create_table "identity_file_folders", force: :cascade do |t|
    t.string   "folder_name",      limit: 255
    t.integer  "parent_folder_id"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "identity_file_folders", ["identity_id"], name: "index_identity_file_folders_on_identity_id", using: :btree
  add_index "identity_file_folders", ["parent_folder_id"], name: "index_identity_file_folders_on_parent_folder_id", using: :btree

  create_table "identity_files", force: :cascade do |t|
    t.integer  "identity_id"
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
    t.boolean  "thumbnail_skip"
    t.string   "thumbnail_hash"
    t.string   "file_hash"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "identity_files", ["encrypted_password_id"], name: "index_identity_files_on_encrypted_password_id", using: :btree
  add_index "identity_files", ["folder_id"], name: "index_identity_files_on_folder_id", using: :btree
  add_index "identity_files", ["identity_id"], name: "index_identity_files_on_identity_id", using: :btree

  create_table "identity_locations", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "parent_identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "identity_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "identity_locations", ["identity_id"], name: "index_identity_locations_on_identity_id", using: :btree
  add_index "identity_locations", ["location_id"], name: "index_identity_locations_on_location_id", using: :btree
  add_index "identity_locations", ["parent_identity_id"], name: "index_identity_locations_on_parent_identity_id", using: :btree

  create_table "identity_phones", force: :cascade do |t|
    t.string   "number",             limit: 255
    t.integer  "parent_identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "identity_id"
    t.integer  "phone_type"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "identity_phones", ["identity_id"], name: "index_identity_phones_on_identity_id", using: :btree
  add_index "identity_phones", ["parent_identity_id"], name: "index_identity_phones_on_parent_identity_id", using: :btree

  create_table "identity_pictures", force: :cascade do |t|
    t.integer  "parent_identity_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "identity_pictures", ["identity_file_id"], name: "index_identity_pictures_on_identity_file_id", using: :btree
  add_index "identity_pictures", ["identity_id"], name: "index_identity_pictures_on_identity_id", using: :btree
  add_index "identity_pictures", ["parent_identity_id"], name: "index_identity_pictures_on_parent_identity_id", using: :btree

  create_table "identity_relationships", force: :cascade do |t|
    t.integer  "contact_id"
    t.integer  "relationship_type"
    t.integer  "identity_id"
    t.integer  "parent_identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "identity_relationships", ["contact_id"], name: "index_identity_relationships_on_contact_id", using: :btree
  add_index "identity_relationships", ["identity_id"], name: "index_identity_relationships_on_identity_id", using: :btree
  add_index "identity_relationships", ["parent_identity_id"], name: "index_identity_relationships_on_parent_identity_id", using: :btree

  create_table "invite_codes", force: :cascade do |t|
    t.string   "code"
    t.integer  "current_uses"
    t.integer  "max_uses"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "invite_codes", ["identity_id"], name: "index_invite_codes_on_identity_id", using: :btree

  create_table "invites", force: :cascade do |t|
    t.string   "email"
    t.text     "invite_body"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "invites", ["user_id"], name: "index_invites_on_user_id", using: :btree

  create_table "job_files", force: :cascade do |t|
    t.integer  "job_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.integer  "position"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "job_files", ["identity_file_id"], name: "index_job_files_on_identity_file_id", using: :btree
  add_index "job_files", ["identity_id"], name: "index_job_files_on_identity_id", using: :btree
  add_index "job_files", ["job_id"], name: "index_job_files_on_job_id", using: :btree

  create_table "job_managers", force: :cascade do |t|
    t.integer  "job_id"
    t.integer  "contact_id"
    t.integer  "identity_id"
    t.date     "start_date"
    t.date     "end_date"
    t.text     "notes"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "job_managers", ["contact_id"], name: "index_job_managers_on_contact_id", using: :btree
  add_index "job_managers", ["identity_id"], name: "index_job_managers_on_identity_id", using: :btree
  add_index "job_managers", ["job_id"], name: "index_job_managers_on_job_id", using: :btree

  create_table "job_myreferences", force: :cascade do |t|
    t.integer  "job_id"
    t.integer  "myreference_id"
    t.integer  "identity_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "job_myreferences", ["identity_id"], name: "index_job_myreferences_on_identity_id", using: :btree
  add_index "job_myreferences", ["job_id"], name: "index_job_myreferences_on_job_id", using: :btree
  add_index "job_myreferences", ["myreference_id"], name: "index_job_myreferences_on_myreference_id", using: :btree

  create_table "job_review_files", force: :cascade do |t|
    t.integer  "job_review_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.integer  "position"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "job_review_files", ["identity_file_id"], name: "index_job_review_files_on_identity_file_id", using: :btree
  add_index "job_review_files", ["identity_id"], name: "index_job_review_files_on_identity_id", using: :btree
  add_index "job_review_files", ["job_review_id"], name: "index_job_review_files_on_job_review_id", using: :btree

  create_table "job_reviews", force: :cascade do |t|
    t.integer  "job_id"
    t.integer  "identity_id"
    t.date     "review_date"
    t.string   "company_score"
    t.integer  "contact_id"
    t.text     "notes"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.datetime "archived"
    t.integer  "rating"
    t.text     "self_evaluation"
  end

  add_index "job_reviews", ["contact_id"], name: "index_job_reviews_on_contact_id", using: :btree
  add_index "job_reviews", ["identity_id"], name: "index_job_reviews_on_identity_id", using: :btree
  add_index "job_reviews", ["job_id"], name: "index_job_reviews_on_job_id", using: :btree

  create_table "job_salaries", force: :cascade do |t|
    t.integer  "identity_id"
    t.integer  "job_id"
    t.date     "started"
    t.date     "ended"
    t.text     "notes"
    t.decimal  "salary",        precision: 10, scale: 2
    t.integer  "salary_period"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "new_title"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "job_salaries", ["identity_id"], name: "index_job_salaries_on_identity_id", using: :btree
  add_index "job_salaries", ["job_id"], name: "index_job_salaries_on_job_id", using: :btree

  create_table "jobs", force: :cascade do |t|
    t.string   "job_title",             limit: 255
    t.integer  "company_id"
    t.date     "started"
    t.date     "ended"
    t.integer  "manager_contact_id"
    t.text     "notes"
    t.integer  "identity_id"
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
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "jobs", ["company_id"], name: "index_jobs_on_company_id", using: :btree
  add_index "jobs", ["identity_id"], name: "index_jobs_on_identity_id", using: :btree
  add_index "jobs", ["internal_address_id"], name: "index_jobs_on_internal_address_id", using: :btree
  add_index "jobs", ["manager_contact_id"], name: "index_jobs_on_manager_contact_id", using: :btree

  create_table "jokes", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "joke"
    t.string   "source",      limit: 255
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "jokes", ["identity_id"], name: "index_jokes_on_identity_id", using: :btree

  create_table "life_goals", force: :cascade do |t|
    t.string   "life_goal_name", limit: 255
    t.text     "notes"
    t.integer  "position"
    t.datetime "goal_started"
    t.datetime "goal_ended"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "life_goals", ["identity_id"], name: "index_life_goals_on_identity_id", using: :btree

  create_table "life_highlights", force: :cascade do |t|
    t.datetime "life_highlight_time"
    t.string   "life_highlight_name"
    t.text     "notes"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
    t.integer  "identity_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "life_highlights", ["identity_id"], name: "index_life_highlights_on_identity_id", using: :btree

  create_table "life_insurances", force: :cascade do |t|
    t.string   "insurance_name",      limit: 255
    t.integer  "company_id"
    t.decimal  "insurance_amount",                precision: 10, scale: 2
    t.date     "started"
    t.integer  "periodic_payment_id"
    t.text     "notes"
    t.integer  "identity_id"
    t.integer  "life_insurance_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "life_insurances", ["company_id"], name: "index_life_insurances_on_company_id", using: :btree
  add_index "life_insurances", ["identity_id"], name: "index_life_insurances_on_identity_id", using: :btree
  add_index "life_insurances", ["periodic_payment_id"], name: "index_life_insurances_on_periodic_payment_id", using: :btree

  create_table "list_items", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "identity_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "list_items", ["identity_id"], name: "index_list_items_on_identity_id", using: :btree
  add_index "list_items", ["list_id"], name: "index_list_items_on_list_id", using: :btree

  create_table "lists", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "lists", ["identity_id"], name: "index_lists_on_identity_id", using: :btree

  create_table "loans", force: :cascade do |t|
    t.string   "lender",          limit: 255
    t.decimal  "amount",                      precision: 10, scale: 2
    t.date     "start"
    t.date     "paid_off"
    t.decimal  "monthly_payment",             precision: 10, scale: 2
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "loans", ["identity_id"], name: "index_loans_on_identity_id", using: :btree

  create_table "location_phones", force: :cascade do |t|
    t.string   "number",      limit: 255
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "identity_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "location_phones", ["identity_id"], name: "index_location_phones_on_identity_id", using: :btree
  add_index "location_phones", ["location_id"], name: "index_location_phones_on_location_id", using: :btree

  create_table "location_pictures", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "location_pictures", ["identity_file_id"], name: "index_location_pictures_on_identity_file_id", using: :btree
  add_index "location_pictures", ["identity_id"], name: "index_location_pictures_on_identity_id", using: :btree
  add_index "location_pictures", ["location_id"], name: "index_location_pictures_on_location_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "address1",    limit: 255
    t.string   "address2",    limit: 255
    t.string   "address3",    limit: 255
    t.string   "region",      limit: 255
    t.string   "sub_region1", limit: 255
    t.string   "sub_region2", limit: 255
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "postal_code", limit: 255
    t.text     "notes"
    t.decimal  "latitude",                precision: 12, scale: 8
    t.decimal  "longitude",               precision: 12, scale: 8
    t.integer  "visit_count"
    t.integer  "website_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "locations", ["identity_id"], name: "index_locations_on_identity_id", using: :btree
  add_index "locations", ["website_id"], name: "index_locations_on_website_id", using: :btree

  create_table "meadows", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "rating"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.text     "notes"
    t.boolean  "visited"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
  end

  add_index "meadows", ["identity_id"], name: "index_meadows_on_identity_id", using: :btree
  add_index "meadows", ["location_id"], name: "index_meadows_on_location_id", using: :btree

  create_table "meal_drinks", force: :cascade do |t|
    t.integer  "identity_id"
    t.integer  "meal_id"
    t.integer  "drink_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "drink_servings", precision: 10, scale: 2
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "meal_drinks", ["drink_id"], name: "index_meal_drinks_on_drink_id", using: :btree
  add_index "meal_drinks", ["identity_id"], name: "index_meal_drinks_on_identity_id", using: :btree
  add_index "meal_drinks", ["meal_id"], name: "index_meal_drinks_on_meal_id", using: :btree

  create_table "meal_foods", force: :cascade do |t|
    t.integer  "identity_id"
    t.integer  "meal_id"
    t.integer  "food_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "food_servings", precision: 10, scale: 2
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "meal_foods", ["food_id"], name: "index_meal_foods_on_food_id", using: :btree
  add_index "meal_foods", ["identity_id"], name: "index_meal_foods_on_identity_id", using: :btree
  add_index "meal_foods", ["meal_id"], name: "index_meal_foods_on_meal_id", using: :btree

  create_table "meal_vitamins", force: :cascade do |t|
    t.integer  "identity_id"
    t.integer  "meal_id"
    t.integer  "vitamin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "meal_vitamins", ["identity_id"], name: "index_meal_vitamins_on_identity_id", using: :btree
  add_index "meal_vitamins", ["meal_id"], name: "index_meal_vitamins_on_meal_id", using: :btree
  add_index "meal_vitamins", ["vitamin_id"], name: "index_meal_vitamins_on_vitamin_id", using: :btree

  create_table "meals", force: :cascade do |t|
    t.datetime "meal_time"
    t.text     "notes"
    t.integer  "location_id"
    t.decimal  "price",       precision: 10, scale: 2
    t.decimal  "calories",    precision: 10, scale: 2
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "meals", ["identity_id"], name: "index_meals_on_identity_id", using: :btree
  add_index "meals", ["location_id"], name: "index_meals_on_location_id", using: :btree

  create_table "media_dump_files", force: :cascade do |t|
    t.integer  "media_dump_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.integer  "position"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "media_dump_files", ["identity_file_id"], name: "index_media_dump_files_on_identity_file_id", using: :btree
  add_index "media_dump_files", ["identity_id"], name: "index_media_dump_files_on_identity_id", using: :btree
  add_index "media_dump_files", ["media_dump_id"], name: "index_media_dump_files_on_media_dump_id", using: :btree

  create_table "media_dumps", force: :cascade do |t|
    t.string   "media_dump_name"
    t.text     "notes"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "media_dumps", ["identity_id"], name: "index_media_dumps_on_identity_id", using: :btree

  create_table "medical_condition_instances", force: :cascade do |t|
    t.datetime "condition_start"
    t.datetime "condition_end"
    t.text     "notes"
    t.integer  "medical_condition_id"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "medical_condition_instances", ["identity_id"], name: "index_medical_condition_instances_on_identity_id", using: :btree
  add_index "medical_condition_instances", ["medical_condition_id"], name: "index_medical_condition_instances_on_medical_condition_id", using: :btree

  create_table "medical_condition_treatments", force: :cascade do |t|
    t.integer  "identity_id"
    t.integer  "medical_condition_id"
    t.date     "treatment_date"
    t.text     "notes"
    t.string   "treatment_description"
    t.integer  "doctor_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "location_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "medical_condition_treatments", ["doctor_id"], name: "index_medical_condition_treatments_on_doctor_id", using: :btree
  add_index "medical_condition_treatments", ["identity_id"], name: "index_medical_condition_treatments_on_identity_id", using: :btree
  add_index "medical_condition_treatments", ["location_id"], name: "index_medical_condition_treatments_on_location_id", using: :btree
  add_index "medical_condition_treatments", ["medical_condition_id"], name: "index_medical_condition_treatments_on_medical_condition_id", using: :btree

  create_table "medical_conditions", force: :cascade do |t|
    t.string   "medical_condition_name", limit: 255
    t.text     "notes"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "medical_conditions", ["identity_id"], name: "index_medical_conditions_on_identity_id", using: :btree

  create_table "medicine_usage_medicines", force: :cascade do |t|
    t.integer  "identity_id"
    t.integer  "medicine_usage_id"
    t.integer  "medicine_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "medicine_usage_medicines", ["identity_id"], name: "index_medicine_usage_medicines_on_identity_id", using: :btree
  add_index "medicine_usage_medicines", ["medicine_id"], name: "index_medicine_usage_medicines_on_medicine_id", using: :btree
  add_index "medicine_usage_medicines", ["medicine_usage_id"], name: "index_medicine_usage_medicines_on_medicine_usage_id", using: :btree

  create_table "medicine_usages", force: :cascade do |t|
    t.datetime "usage_time"
    t.integer  "medicine_id"
    t.text     "usage_notes"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "medicine_usages", ["identity_id"], name: "index_medicine_usages_on_identity_id", using: :btree
  add_index "medicine_usages", ["medicine_id"], name: "index_medicine_usages_on_medicine_id", using: :btree

  create_table "medicines", force: :cascade do |t|
    t.string   "medicine_name", limit: 255
    t.decimal  "dosage",                    precision: 10, scale: 2
    t.integer  "dosage_type"
    t.text     "notes"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "medicines", ["identity_id"], name: "index_medicines_on_identity_id", using: :btree

  create_table "membership_files", force: :cascade do |t|
    t.integer  "membership_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.integer  "position"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "membership_files", ["identity_file_id"], name: "index_membership_files_on_identity_file_id", using: :btree
  add_index "membership_files", ["identity_id"], name: "index_membership_files_on_identity_id", using: :btree
  add_index "membership_files", ["membership_id"], name: "index_membership_files_on_membership_id", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
    t.integer  "periodic_payment_id"
    t.integer  "visit_count"
    t.string   "membership_identifier", limit: 255
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "memberships", ["identity_id"], name: "index_memberships_on_identity_id", using: :btree
  add_index "memberships", ["periodic_payment_id"], name: "index_memberships_on_periodic_payment_id", using: :btree

  create_table "message_contacts", force: :cascade do |t|
    t.integer  "message_id"
    t.integer  "contact_id"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "message_contacts", ["contact_id"], name: "index_message_contacts_on_contact_id", using: :btree
  add_index "message_contacts", ["identity_id"], name: "index_message_contacts_on_identity_id", using: :btree
  add_index "message_contacts", ["message_id"], name: "index_message_contacts_on_message_id", using: :btree

  create_table "message_groups", force: :cascade do |t|
    t.integer  "message_id"
    t.integer  "group_id"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "message_groups", ["group_id"], name: "index_message_groups_on_group_id", using: :btree
  add_index "message_groups", ["identity_id"], name: "index_message_groups_on_identity_id", using: :btree
  add_index "message_groups", ["message_id"], name: "index_message_groups_on_message_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.boolean  "copy_self"
    t.string   "message_category"
    t.boolean  "draft"
    t.boolean  "personalize"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.boolean  "send_emails"
    t.boolean  "send_texts"
    t.string   "subject"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "messages", ["identity_id"], name: "index_messages_on_identity_id", using: :btree

  create_table "money_balance_item_templates", force: :cascade do |t|
    t.decimal  "amount",                  precision: 10, scale: 2
    t.decimal  "original_amount",         precision: 10, scale: 2
    t.string   "money_balance_item_name"
    t.text     "notes"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.integer  "money_balance_id"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "money_balance_item_templates", ["identity_id"], name: "index_money_balance_item_templates_on_identity_id", using: :btree
  add_index "money_balance_item_templates", ["money_balance_id"], name: "index_money_balance_item_templates_on_money_balance_id", using: :btree

  create_table "money_balance_items", force: :cascade do |t|
    t.integer  "money_balance_id"
    t.integer  "identity_id"
    t.decimal  "amount",                  precision: 10, scale: 2
    t.datetime "item_time"
    t.string   "money_balance_item_name"
    t.text     "notes"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.decimal  "original_amount",         precision: 10, scale: 2
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "money_balance_items", ["identity_id"], name: "index_money_balance_items_on_identity_id", using: :btree
  add_index "money_balance_items", ["money_balance_id"], name: "index_money_balance_items_on_money_balance_id", using: :btree

  create_table "money_balances", force: :cascade do |t|
    t.integer  "contact_id"
    t.text     "notes"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "money_balances", ["contact_id"], name: "index_money_balances_on_contact_id", using: :btree
  add_index "money_balances", ["identity_id"], name: "index_money_balances_on_identity_id", using: :btree

  create_table "movie_theaters", force: :cascade do |t|
    t.string   "theater_name", limit: 255
    t.integer  "location_id"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "movie_theaters", ["identity_id"], name: "index_movie_theaters_on_identity_id", using: :btree
  add_index "movie_theaters", ["location_id"], name: "index_movie_theaters_on_location_id", using: :btree

  create_table "movies", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.datetime "watched"
    t.string   "url",            limit: 255
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.integer  "recommender_id"
    t.string   "genre"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "movies", ["identity_id"], name: "index_movies_on_identity_id", using: :btree
  add_index "movies", ["recommender_id"], name: "index_movies_on_recommender_id", using: :btree

  create_table "museums", force: :cascade do |t|
    t.integer  "location_id"
    t.string   "museum_id",     limit: 255
    t.integer  "website_id"
    t.integer  "museum_type"
    t.text     "notes"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "museum_source", limit: 255
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "museums", ["identity_id"], name: "index_museums_on_identity_id", using: :btree
  add_index "museums", ["location_id"], name: "index_museums_on_location_id", using: :btree
  add_index "museums", ["website_id"], name: "index_museums_on_website_id", using: :btree

  create_table "musical_groups", force: :cascade do |t|
    t.string   "musical_group_name", limit: 255
    t.text     "notes"
    t.datetime "listened"
    t.integer  "rating"
    t.boolean  "awesome"
    t.boolean  "secret"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "musical_genre",      limit: 255
    t.integer  "visit_count"
    t.datetime "archived"
  end

  add_index "musical_groups", ["identity_id"], name: "index_musical_groups_on_identity_id", using: :btree

  create_table "myplaceonline_quick_category_displays", force: :cascade do |t|
    t.boolean  "trash"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "myplaceonline_quick_category_displays", ["identity_id"], name: "index_myplaceonline_quick_category_displays_on_identity_id", using: :btree

  create_table "myplaceonline_searches", force: :cascade do |t|
    t.integer  "identity_id"
    t.boolean  "trash"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "myplaceonline_searches", ["identity_id"], name: "index_myplaceonline_searches_on_identity_id", using: :btree

  create_table "myplets", force: :cascade do |t|
    t.integer  "x_coordinate"
    t.integer  "y_coordinate"
    t.string   "title",         limit: 255
    t.string   "category_name", limit: 255
    t.integer  "category_id"
    t.integer  "border_type"
    t.boolean  "collapsed"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "myplets", ["identity_id"], name: "index_myplets_on_identity_id", using: :btree

  create_table "myreferences", force: :cascade do |t|
    t.integer  "contact_id"
    t.text     "notes"
    t.integer  "reference_type"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "myreferences", ["contact_id"], name: "index_myreferences_on_contact_id", using: :btree
  add_index "myreferences", ["identity_id"], name: "index_myreferences_on_identity_id", using: :btree

  create_table "notepads", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.text     "notepad_data"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "notepads", ["identity_id"], name: "index_notepads_on_identity_id", using: :btree

  create_table "pains", force: :cascade do |t|
    t.string   "pain_location",   limit: 255
    t.integer  "intensity"
    t.datetime "pain_start_time"
    t.datetime "pain_end_time"
    t.text     "notes"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "pains", ["identity_id"], name: "index_pains_on_identity_id", using: :btree

  create_table "passport_pictures", force: :cascade do |t|
    t.integer  "passport_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "passport_pictures", ["identity_file_id"], name: "index_passport_pictures_on_identity_file_id", using: :btree
  add_index "passport_pictures", ["identity_id"], name: "index_passport_pictures_on_identity_id", using: :btree
  add_index "passport_pictures", ["passport_id"], name: "index_passport_pictures_on_passport_id", using: :btree

  create_table "passports", force: :cascade do |t|
    t.string   "region",            limit: 255
    t.string   "passport_number",   limit: 255
    t.date     "expires"
    t.date     "issued"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "issuing_authority", limit: 255
    t.string   "name",              limit: 255
    t.integer  "visit_count"
    t.text     "notes"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "passports", ["identity_id"], name: "index_passports_on_identity_id", using: :btree

  create_table "password_secret_shares", force: :cascade do |t|
    t.integer  "password_secret_id"
    t.integer  "password_share_id"
    t.integer  "identity_id"
    t.string   "unencrypted_answer"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "password_secret_shares", ["identity_id"], name: "index_password_secret_shares_on_identity_id", using: :btree
  add_index "password_secret_shares", ["password_secret_id"], name: "index_password_secret_shares_on_password_secret_id", using: :btree
  add_index "password_secret_shares", ["password_share_id"], name: "index_password_secret_shares_on_password_share_id", using: :btree

  create_table "password_secrets", force: :cascade do |t|
    t.string   "question",            limit: 255
    t.string   "answer",              limit: 255
    t.integer  "answer_encrypted_id"
    t.integer  "password_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "identity_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "password_secrets", ["answer_encrypted_id"], name: "index_password_secrets_on_answer_encrypted_id", using: :btree
  add_index "password_secrets", ["identity_id"], name: "index_password_secrets_on_identity_id", using: :btree
  add_index "password_secrets", ["password_id"], name: "index_password_secrets_on_password_id", using: :btree

  create_table "password_shares", force: :cascade do |t|
    t.integer  "password_id"
    t.integer  "user_id"
    t.integer  "identity_id"
    t.string   "unencrypted_password"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "password_shares", ["identity_id"], name: "index_password_shares_on_identity_id", using: :btree
  add_index "password_shares", ["password_id"], name: "index_password_shares_on_password_id", using: :btree
  add_index "password_shares", ["user_id"], name: "index_password_shares_on_user_id", using: :btree

  create_table "passwords", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.string   "user",                  limit: 255
    t.string   "password",              limit: 255
    t.string   "url",                   limit: 2000
    t.text     "notes"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "password_encrypted_id"
    t.string   "account_number",        limit: 255
    t.datetime "archived"
    t.string   "email",                 limit: 255
    t.integer  "visit_count"
    t.integer  "rating"
  end

  add_index "passwords", ["identity_id"], name: "index_passwords_on_identity_id", using: :btree
  add_index "passwords", ["password_encrypted_id"], name: "index_passwords_on_password_encrypted_id", using: :btree

  create_table "periodic_payments", force: :cascade do |t|
    t.string   "periodic_payment_name", limit: 255
    t.text     "notes"
    t.date     "started"
    t.date     "ended"
    t.integer  "date_period"
    t.decimal  "payment_amount",                    precision: 10, scale: 2
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.boolean  "suppress_reminder"
    t.integer  "password_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "periodic_payments", ["identity_id"], name: "index_periodic_payments_on_identity_id", using: :btree
  add_index "periodic_payments", ["password_id"], name: "index_periodic_payments_on_password_id", using: :btree

  create_table "permission_share_children", force: :cascade do |t|
    t.string   "subject_class"
    t.integer  "subject_id"
    t.integer  "permission_share_id"
    t.integer  "identity_id"
    t.integer  "share_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "permission_share_children", ["identity_id"], name: "index_permission_share_children_on_identity_id", using: :btree
  add_index "permission_share_children", ["permission_share_id"], name: "index_permission_share_children_on_permission_share_id", using: :btree
  add_index "permission_share_children", ["share_id"], name: "index_permission_share_children_on_share_id", using: :btree

  create_table "permission_shares", force: :cascade do |t|
    t.string   "subject_class"
    t.integer  "subject_id"
    t.string   "subject"
    t.text     "body"
    t.boolean  "copy_self"
    t.integer  "share_id"
    t.integer  "identity_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "email_id"
    t.string   "child_selections"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "permission_shares", ["email_id"], name: "index_permission_shares_on_email_id", using: :btree
  add_index "permission_shares", ["identity_id"], name: "index_permission_shares_on_identity_id", using: :btree
  add_index "permission_shares", ["share_id"], name: "index_permission_shares_on_share_id", using: :btree

  create_table "permissions", force: :cascade do |t|
    t.integer  "action"
    t.string   "subject_class"
    t.integer  "subject_id"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "permissions", ["identity_id"], name: "index_permissions_on_identity_id", using: :btree
  add_index "permissions", ["user_id"], name: "index_permissions_on_user_id", using: :btree

  create_table "phone_files", force: :cascade do |t|
    t.integer  "phone_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "phone_files", ["identity_file_id"], name: "index_phone_files_on_identity_file_id", using: :btree
  add_index "phone_files", ["identity_id"], name: "index_phone_files_on_identity_id", using: :btree
  add_index "phone_files", ["phone_id"], name: "index_phone_files_on_phone_id", using: :btree

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
    t.integer  "identity_id"
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
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "phones", ["identity_id"], name: "index_phones_on_identity_id", using: :btree
  add_index "phones", ["manufacturer_id"], name: "index_phones_on_manufacturer_id", using: :btree
  add_index "phones", ["password_id"], name: "index_phones_on_password_id", using: :btree

  create_table "playlist_songs", force: :cascade do |t|
    t.integer  "playlist_id"
    t.integer  "song_id"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "playlist_songs", ["identity_id"], name: "index_playlist_songs_on_identity_id", using: :btree
  add_index "playlist_songs", ["playlist_id"], name: "index_playlist_songs_on_playlist_id", using: :btree
  add_index "playlist_songs", ["song_id"], name: "index_playlist_songs_on_song_id", using: :btree

  create_table "playlists", force: :cascade do |t|
    t.string   "playlist_name",    limit: 255
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "identity_file_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "playlists", ["identity_file_id"], name: "index_playlists_on_identity_file_id", using: :btree
  add_index "playlists", ["identity_id"], name: "index_playlists_on_identity_id", using: :btree

  create_table "podcasts", force: :cascade do |t|
    t.integer  "feed_id"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "podcasts", ["feed_id"], name: "index_podcasts_on_feed_id", using: :btree
  add_index "podcasts", ["identity_id"], name: "index_podcasts_on_identity_id", using: :btree

  create_table "poems", force: :cascade do |t|
    t.string   "poem_name",   limit: 255
    t.text     "poem"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "poems", ["identity_id"], name: "index_poems_on_identity_id", using: :btree

  create_table "point_displays", force: :cascade do |t|
    t.boolean  "trash"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "point_displays", ["identity_id"], name: "index_point_displays_on_identity_id", using: :btree

  create_table "problem_report_files", force: :cascade do |t|
    t.integer  "problem_report_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.integer  "position"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "problem_report_files", ["identity_file_id"], name: "index_problem_report_files_on_identity_file_id", using: :btree
  add_index "problem_report_files", ["identity_id"], name: "index_problem_report_files_on_identity_id", using: :btree
  add_index "problem_report_files", ["problem_report_id"], name: "index_problem_report_files_on_problem_report_id", using: :btree

  create_table "problem_reports", force: :cascade do |t|
    t.string   "report_name"
    t.text     "notes"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "problem_reports", ["identity_id"], name: "index_problem_reports_on_identity_id", using: :btree

  create_table "project_issue_files", force: :cascade do |t|
    t.integer  "project_issue_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.integer  "position"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "project_issue_files", ["identity_file_id"], name: "index_project_issue_files_on_identity_file_id", using: :btree
  add_index "project_issue_files", ["identity_id"], name: "index_project_issue_files_on_identity_id", using: :btree
  add_index "project_issue_files", ["project_issue_id"], name: "index_project_issue_files_on_project_issue_id", using: :btree

  create_table "project_issue_notifiers", force: :cascade do |t|
    t.integer  "contact_id"
    t.integer  "project_issue_id"
    t.integer  "identity_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "project_issue_notifiers", ["contact_id"], name: "index_project_issue_notifiers_on_contact_id", using: :btree
  add_index "project_issue_notifiers", ["identity_id"], name: "index_project_issue_notifiers_on_identity_id", using: :btree
  add_index "project_issue_notifiers", ["project_issue_id"], name: "index_project_issue_notifiers_on_project_issue_id", using: :btree

  create_table "project_issues", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "identity_id"
    t.integer  "position"
    t.string   "issue_name"
    t.text     "notes"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "project_issues", ["identity_id"], name: "index_project_issues_on_identity_id", using: :btree
  add_index "project_issues", ["project_id"], name: "index_project_issues_on_project_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "project_name"
    t.text     "notes"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "projects", ["identity_id"], name: "index_projects_on_identity_id", using: :btree

  create_table "promises", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.date     "due"
    t.text     "promise"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "promises", ["identity_id"], name: "index_promises_on_identity_id", using: :btree

  create_table "promotions", force: :cascade do |t|
    t.string   "promotion_name",   limit: 255
    t.date     "started"
    t.date     "expires"
    t.decimal  "promotion_amount",             precision: 10, scale: 2
    t.text     "notes"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "promotions", ["identity_id"], name: "index_promotions_on_identity_id", using: :btree

  create_table "quest_files", force: :cascade do |t|
    t.integer  "quest_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.integer  "position"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "quest_files", ["identity_file_id"], name: "index_quest_files_on_identity_file_id", using: :btree
  add_index "quest_files", ["identity_id"], name: "index_quest_files_on_identity_id", using: :btree
  add_index "quest_files", ["quest_id"], name: "index_quest_files_on_quest_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "notes"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "questions", ["identity_id"], name: "index_questions_on_identity_id", using: :btree

  create_table "quests", force: :cascade do |t|
    t.string   "quest_title"
    t.text     "notes"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "quests", ["identity_id"], name: "index_quests_on_identity_id", using: :btree

  create_table "receipt_files", force: :cascade do |t|
    t.integer  "receipt_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "receipt_files", ["identity_file_id"], name: "index_receipt_files_on_identity_file_id", using: :btree
  add_index "receipt_files", ["identity_id"], name: "index_receipt_files_on_identity_id", using: :btree
  add_index "receipt_files", ["receipt_id"], name: "index_receipt_files_on_receipt_id", using: :btree

  create_table "receipts", force: :cascade do |t|
    t.string   "receipt_name"
    t.datetime "receipt_time"
    t.decimal  "amount",       precision: 10, scale: 2
    t.text     "notes"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "receipts", ["identity_id"], name: "index_receipts_on_identity_id", using: :btree

  create_table "recipe_pictures", force: :cascade do |t|
    t.integer  "recipe_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "recipe_pictures", ["identity_file_id"], name: "index_recipe_pictures_on_identity_file_id", using: :btree
  add_index "recipe_pictures", ["identity_id"], name: "index_recipe_pictures_on_identity_id", using: :btree
  add_index "recipe_pictures", ["recipe_id"], name: "index_recipe_pictures_on_recipe_id", using: :btree

  create_table "recipes", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.text     "recipe"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.string   "recipe_category"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "recipes", ["identity_id"], name: "index_recipes_on_identity_id", using: :btree

  create_table "recreational_vehicle_insurances", force: :cascade do |t|
    t.string   "insurance_name",          limit: 255
    t.integer  "company_id"
    t.date     "started"
    t.integer  "periodic_payment_id"
    t.text     "notes"
    t.integer  "recreational_vehicle_id"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "recreational_vehicle_insurances", ["company_id"], name: "index_recreational_vehicle_insurances_on_company_id", using: :btree
  add_index "recreational_vehicle_insurances", ["identity_id"], name: "index_recreational_vehicle_insurances_on_identity_id", using: :btree
  add_index "recreational_vehicle_insurances", ["periodic_payment_id"], name: "index_recreational_vehicle_insurances_on_periodic_payment_id", using: :btree

  create_table "recreational_vehicle_loans", force: :cascade do |t|
    t.integer  "recreational_vehicle_id"
    t.integer  "loan_id"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "recreational_vehicle_loans", ["identity_id"], name: "index_recreational_vehicle_loans_on_identity_id", using: :btree
  add_index "recreational_vehicle_loans", ["loan_id"], name: "index_recreational_vehicle_loans_on_loan_id", using: :btree
  add_index "recreational_vehicle_loans", ["recreational_vehicle_id"], name: "index_recreational_vehicle_loans_on_recreational_vehicle_id", using: :btree

  create_table "recreational_vehicle_measurements", force: :cascade do |t|
    t.string   "measurement_name",        limit: 255
    t.integer  "measurement_type"
    t.decimal  "width",                               precision: 10, scale: 2
    t.decimal  "height",                              precision: 10, scale: 2
    t.decimal  "depth",                               precision: 10, scale: 2
    t.text     "notes"
    t.integer  "identity_id"
    t.integer  "recreational_vehicle_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "recreational_vehicle_measurements", ["identity_id"], name: "index_recreational_vehicle_measurements_on_identity_id", using: :btree

  create_table "recreational_vehicle_pictures", force: :cascade do |t|
    t.integer  "recreational_vehicle_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "recreational_vehicle_pictures", ["identity_file_id"], name: "index_recreational_vehicle_pictures_on_identity_file_id", using: :btree
  add_index "recreational_vehicle_pictures", ["identity_id"], name: "index_recreational_vehicle_pictures_on_identity_id", using: :btree
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
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "exterior_length_over",              precision: 10, scale: 2
    t.decimal  "slideouts_extra_width",             precision: 10, scale: 2
    t.decimal  "floor_length",                      precision: 10, scale: 2
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "recreational_vehicles", ["identity_id"], name: "index_recreational_vehicles_on_identity_id", using: :btree
  add_index "recreational_vehicles", ["location_purchased_id"], name: "index_recreational_vehicles_on_location_purchased_id", using: :btree
  add_index "recreational_vehicles", ["vehicle_id"], name: "index_recreational_vehicles_on_vehicle_id", using: :btree

  create_table "repeats", force: :cascade do |t|
    t.date     "start_date"
    t.integer  "period_type"
    t.integer  "period"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "repeats", ["identity_id"], name: "index_repeats_on_identity_id", using: :btree

  create_table "restaurant_pictures", force: :cascade do |t|
    t.integer  "restaurant_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "restaurant_pictures", ["identity_file_id"], name: "index_restaurant_pictures_on_identity_file_id", using: :btree
  add_index "restaurant_pictures", ["identity_id"], name: "index_restaurant_pictures_on_identity_id", using: :btree
  add_index "restaurant_pictures", ["restaurant_id"], name: "index_restaurant_pictures_on_restaurant_id", using: :btree

  create_table "restaurants", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "rating"
    t.text     "notes"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.boolean  "visited"
    t.datetime "archived"
  end

  add_index "restaurants", ["identity_id"], name: "index_restaurants_on_identity_id", using: :btree
  add_index "restaurants", ["location_id"], name: "index_restaurants_on_location_id", using: :btree

  create_table "reward_programs", force: :cascade do |t|
    t.string   "reward_program_name",   limit: 255
    t.date     "started"
    t.date     "ended"
    t.string   "reward_program_number", limit: 255
    t.string   "reward_program_status", limit: 255
    t.text     "notes"
    t.integer  "password_id"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "program_type"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "reward_programs", ["identity_id"], name: "index_reward_programs_on_identity_id", using: :btree
  add_index "reward_programs", ["password_id"], name: "index_reward_programs_on_password_id", using: :btree

  create_table "shares", force: :cascade do |t|
    t.string   "token",         limit: 255
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "use_count"
    t.integer  "max_use_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "shares", ["identity_id"], name: "index_shares_on_identity_id", using: :btree

  create_table "shopping_list_items", force: :cascade do |t|
    t.integer  "identity_id"
    t.integer  "shopping_list_id"
    t.string   "shopping_list_item_name", limit: 255
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "shopping_list_items", ["identity_id"], name: "index_shopping_list_items_on_identity_id", using: :btree
  add_index "shopping_list_items", ["shopping_list_id"], name: "index_shopping_list_items_on_shopping_list_id", using: :btree

  create_table "shopping_lists", force: :cascade do |t|
    t.string   "shopping_list_name", limit: 255
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "shopping_lists", ["identity_id"], name: "index_shopping_lists_on_identity_id", using: :btree

  create_table "site_contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skin_treatments", force: :cascade do |t|
    t.datetime "treatment_time"
    t.string   "treatment_activity", limit: 255
    t.string   "treatment_location", limit: 255
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "skin_treatments", ["identity_id"], name: "index_skin_treatments_on_identity_id", using: :btree

  create_table "sleep_measurements", force: :cascade do |t|
    t.datetime "sleep_start_time"
    t.datetime "sleep_end_time"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "sleep_measurements", ["identity_id"], name: "index_sleep_measurements_on_identity_id", using: :btree

  create_table "snoozed_due_items", force: :cascade do |t|
    t.integer  "identity_id"
    t.string   "display",           limit: 255
    t.string   "link",              limit: 255
    t.datetime "due_date"
    t.datetime "original_due_date"
    t.string   "myp_model_name",    limit: 255
    t.integer  "model_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "calendar_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "snoozed_due_items", ["calendar_id"], name: "index_snoozed_due_items_on_calendar_id", using: :btree
  add_index "snoozed_due_items", ["identity_id"], name: "index_snoozed_due_items_on_identity_id", using: :btree

  create_table "songs", force: :cascade do |t|
    t.string   "song_name",        limit: 255
    t.decimal  "song_rating",                  precision: 10, scale: 2
    t.text     "lyrics"
    t.integer  "song_plays"
    t.datetime "lastplay"
    t.boolean  "secret"
    t.boolean  "awesome"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.integer  "identity_file_id"
    t.integer  "musical_group_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "songs", ["identity_file_id"], name: "index_songs_on_identity_file_id", using: :btree
  add_index "songs", ["identity_id"], name: "index_songs_on_identity_id", using: :btree
  add_index "songs", ["musical_group_id"], name: "index_songs_on_musical_group_id", using: :btree

  create_table "ssh_keys", force: :cascade do |t|
    t.string   "ssh_key_name"
    t.text     "ssh_private_key"
    t.text     "ssh_public_key"
    t.integer  "password_id"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "ssh_private_key_encrypted_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "ssh_keys", ["identity_id"], name: "index_ssh_keys_on_identity_id", using: :btree
  add_index "ssh_keys", ["password_id"], name: "index_ssh_keys_on_password_id", using: :btree
  add_index "ssh_keys", ["ssh_private_key_encrypted_id"], name: "index_ssh_keys_on_ssh_private_key_encrypted_id", using: :btree

  create_table "statuses", force: :cascade do |t|
    t.datetime "status_time"
    t.text     "three_good_things"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "feeling"
    t.integer  "visit_count"
    t.string   "status1",           limit: 255
    t.string   "status2",           limit: 255
    t.string   "status3",           limit: 255
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "statuses", ["identity_id"], name: "index_statuses_on_identity_id", using: :btree

  create_table "stocks", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "num_shares"
    t.text     "notes"
    t.date     "vest_date"
    t.integer  "password_id"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "stocks", ["company_id"], name: "index_stocks_on_company_id", using: :btree
  add_index "stocks", ["identity_id"], name: "index_stocks_on_identity_id", using: :btree
  add_index "stocks", ["password_id"], name: "index_stocks_on_password_id", using: :btree

  create_table "stories", force: :cascade do |t|
    t.string   "story_name"
    t.text     "story"
    t.datetime "story_time"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "stories", ["identity_id"], name: "index_stories_on_identity_id", using: :btree

  create_table "story_pictures", force: :cascade do |t|
    t.integer  "story_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "story_pictures", ["identity_file_id"], name: "index_story_pictures_on_identity_file_id", using: :btree
  add_index "story_pictures", ["identity_id"], name: "index_story_pictures_on_identity_id", using: :btree
  add_index "story_pictures", ["story_id"], name: "index_story_pictures_on_story_id", using: :btree

  create_table "sun_exposures", force: :cascade do |t|
    t.datetime "exposure_start"
    t.datetime "exposure_end"
    t.string   "uncovered_body_parts",   limit: 255
    t.string   "sunscreened_body_parts", limit: 255
    t.string   "sunscreen_type",         limit: 255
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "sun_exposures", ["identity_id"], name: "index_sun_exposures_on_identity_id", using: :btree

  create_table "temperatures", force: :cascade do |t|
    t.datetime "measured"
    t.decimal  "measured_temperature",             precision: 10, scale: 2
    t.string   "measurement_source",   limit: 255
    t.integer  "temperature_type"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "temperatures", ["identity_id"], name: "index_temperatures_on_identity_id", using: :btree

  create_table "text_message_contacts", force: :cascade do |t|
    t.integer  "text_message_id"
    t.integer  "contact_id"
    t.integer  "identity_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "text_message_contacts", ["contact_id"], name: "index_text_message_contacts_on_contact_id", using: :btree
  add_index "text_message_contacts", ["identity_id"], name: "index_text_message_contacts_on_identity_id", using: :btree
  add_index "text_message_contacts", ["text_message_id"], name: "index_text_message_contacts_on_text_message_id", using: :btree

  create_table "text_message_groups", force: :cascade do |t|
    t.integer  "text_message_id"
    t.integer  "group_id"
    t.integer  "identity_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "text_message_groups", ["group_id"], name: "index_text_message_groups_on_group_id", using: :btree
  add_index "text_message_groups", ["identity_id"], name: "index_text_message_groups_on_identity_id", using: :btree
  add_index "text_message_groups", ["text_message_id"], name: "index_text_message_groups_on_text_message_id", using: :btree

  create_table "text_message_unsubscriptions", force: :cascade do |t|
    t.string   "phone_number"
    t.string   "category"
    t.integer  "identity_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "text_message_unsubscriptions", ["identity_id"], name: "index_text_message_unsubscriptions_on_identity_id", using: :btree

  create_table "text_messages", force: :cascade do |t|
    t.text     "body"
    t.boolean  "copy_self"
    t.string   "message_category"
    t.boolean  "draft"
    t.boolean  "personalize"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "text_messages", ["identity_id"], name: "index_text_messages_on_identity_id", using: :btree

  create_table "therapists", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "notes"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contact_id"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "therapists", ["contact_id"], name: "index_therapists_on_contact_id", using: :btree
  add_index "therapists", ["identity_id"], name: "index_therapists_on_identity_id", using: :btree

  create_table "timing_events", force: :cascade do |t|
    t.integer  "timing_id"
    t.datetime "timing_event_start"
    t.datetime "timing_event_end"
    t.text     "notes"
    t.integer  "identity_id"
    t.integer  "visit_count"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "timing_events", ["identity_id"], name: "index_timing_events_on_identity_id", using: :btree
  add_index "timing_events", ["timing_id"], name: "index_timing_events_on_timing_id", using: :btree

  create_table "timings", force: :cascade do |t|
    t.string   "timing_name"
    t.text     "notes"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "timings", ["identity_id"], name: "index_timings_on_identity_id", using: :btree

  create_table "to_dos", force: :cascade do |t|
    t.string   "short_description", limit: 255
    t.text     "notes"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "due_time"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "to_dos", ["identity_id"], name: "index_to_dos_on_identity_id", using: :btree

  create_table "trek_pictures", force: :cascade do |t|
    t.integer  "trek_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "trek_pictures", ["identity_file_id"], name: "index_trek_pictures_on_identity_file_id", using: :btree
  add_index "trek_pictures", ["identity_id"], name: "index_trek_pictures_on_identity_id", using: :btree
  add_index "trek_pictures", ["trek_id"], name: "index_trek_pictures_on_trek_id", using: :btree

  create_table "treks", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "rating"
    t.text     "notes"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
  end

  add_index "treks", ["identity_id"], name: "index_treks_on_identity_id", using: :btree
  add_index "treks", ["location_id"], name: "index_treks_on_location_id", using: :btree

  create_table "trip_flights", force: :cascade do |t|
    t.integer  "trip_id"
    t.integer  "flight_id"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "trip_flights", ["flight_id"], name: "index_trip_flights_on_flight_id", using: :btree
  add_index "trip_flights", ["identity_id"], name: "index_trip_flights_on_identity_id", using: :btree
  add_index "trip_flights", ["trip_id"], name: "index_trip_flights_on_trip_id", using: :btree

  create_table "trip_pictures", force: :cascade do |t|
    t.integer  "identity_id"
    t.integer  "trip_id"
    t.integer  "identity_file_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "trip_pictures", ["identity_file_id"], name: "index_trip_pictures_on_identity_file_id", using: :btree
  add_index "trip_pictures", ["identity_id"], name: "index_trip_pictures_on_identity_id", using: :btree
  add_index "trip_pictures", ["trip_id"], name: "index_trip_pictures_on_trip_id", using: :btree

  create_table "trip_stories", force: :cascade do |t|
    t.integer  "trip_id"
    t.integer  "story_id"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "trip_stories", ["identity_id"], name: "index_trip_stories_on_identity_id", using: :btree
  add_index "trip_stories", ["story_id"], name: "index_trip_stories_on_story_id", using: :btree
  add_index "trip_stories", ["trip_id"], name: "index_trip_stories_on_trip_id", using: :btree

  create_table "trips", force: :cascade do |t|
    t.integer  "location_id"
    t.date     "started"
    t.date     "ended"
    t.text     "notes"
    t.boolean  "work"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.integer  "hotel_id"
    t.integer  "identity_file_id"
    t.boolean  "notify_emergency_contacts"
    t.boolean  "explicitly_completed"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "trips", ["hotel_id"], name: "index_trips_on_hotel_id", using: :btree
  add_index "trips", ["identity_file_id"], name: "index_trips_on_identity_file_id", using: :btree
  add_index "trips", ["identity_id"], name: "index_trips_on_identity_id", using: :btree
  add_index "trips", ["location_id"], name: "index_trips_on_location_id", using: :btree

  create_table "tv_shows", force: :cascade do |t|
    t.string   "tv_show_name"
    t.text     "notes"
    t.datetime "watched"
    t.string   "url"
    t.integer  "recommender_id"
    t.string   "tv_genre"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "tv_shows", ["identity_id"], name: "index_tv_shows_on_identity_id", using: :btree
  add_index "tv_shows", ["recommender_id"], name: "index_tv_shows_on_recommender_id", using: :btree

  create_table "us_zip_codes", force: :cascade do |t|
    t.string   "zip_code"
    t.string   "city"
    t.string   "state"
    t.string   "county"
    t.decimal  "latitude",   precision: 12, scale: 8
    t.decimal  "longitude",  precision: 12, scale: 8
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

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
    t.boolean  "experimental_categories"
    t.integer  "items_per_page"
    t.boolean  "show_timestamps"
    t.boolean  "always_enable_debug"
    t.integer  "top_left_icon"
    t.integer  "recently_visited_categories"
    t.integer  "most_visited_categories"
    t.integer  "most_visited_items"
    t.boolean  "minimize_password_checks"
    t.integer  "suppressions"
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
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "vehicle_insurances", ["company_id"], name: "index_vehicle_insurances_on_company_id", using: :btree
  add_index "vehicle_insurances", ["identity_id"], name: "index_vehicle_insurances_on_identity_id", using: :btree
  add_index "vehicle_insurances", ["periodic_payment_id"], name: "index_vehicle_insurances_on_periodic_payment_id", using: :btree
  add_index "vehicle_insurances", ["vehicle_id"], name: "index_vehicle_insurances_on_vehicle_id", using: :btree

  create_table "vehicle_loans", force: :cascade do |t|
    t.integer  "vehicle_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "loan_id"
    t.integer  "identity_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "vehicle_loans", ["identity_id"], name: "index_vehicle_loans_on_identity_id", using: :btree
  add_index "vehicle_loans", ["vehicle_id"], name: "index_vehicle_loans_on_vehicle_id", using: :btree

  create_table "vehicle_pictures", force: :cascade do |t|
    t.integer  "vehicle_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "vehicle_pictures", ["identity_file_id"], name: "index_vehicle_pictures_on_identity_file_id", using: :btree
  add_index "vehicle_pictures", ["identity_id"], name: "index_vehicle_pictures_on_identity_id", using: :btree
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
    t.integer  "identity_id"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "vehicle_services", ["identity_id"], name: "index_vehicle_services_on_identity_id", using: :btree
  add_index "vehicle_services", ["vehicle_id"], name: "index_vehicle_services_on_vehicle_id", using: :btree

  create_table "vehicle_warranties", force: :cascade do |t|
    t.integer  "identity_id"
    t.integer  "warranty_id"
    t.integer  "vehicle_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "vehicle_warranties", ["identity_id"], name: "index_vehicle_warranties_on_identity_id", using: :btree
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
    t.integer  "identity_id"
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
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "vehicles", ["identity_id"], name: "index_vehicles_on_identity_id", using: :btree

  create_table "vitamin_ingredients", force: :cascade do |t|
    t.integer  "identity_id"
    t.integer  "parent_vitamin_id"
    t.integer  "vitamin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "vitamin_ingredients", ["identity_id"], name: "index_vitamin_ingredients_on_identity_id", using: :btree
  add_index "vitamin_ingredients", ["parent_vitamin_id"], name: "index_vitamin_ingredients_on_parent_vitamin_id", using: :btree
  add_index "vitamin_ingredients", ["vitamin_id"], name: "index_vitamin_ingredients_on_vitamin_id", using: :btree

  create_table "vitamins", force: :cascade do |t|
    t.integer  "identity_id"
    t.string   "vitamin_name",   limit: 255
    t.text     "notes"
    t.decimal  "vitamin_amount",             precision: 10, scale: 2
    t.integer  "amount_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "vitamins", ["identity_id"], name: "index_vitamins_on_identity_id", using: :btree

  create_table "volunteering_activities", force: :cascade do |t|
    t.string   "volunteering_activity_name"
    t.text     "notes"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "volunteering_activities", ["identity_id"], name: "index_volunteering_activities_on_identity_id", using: :btree

  create_table "warranties", force: :cascade do |t|
    t.string   "warranty_name",      limit: 255
    t.date     "warranty_start"
    t.date     "warranty_end"
    t.string   "warranty_condition", limit: 255
    t.text     "notes"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "warranties", ["identity_id"], name: "index_warranties_on_identity_id", using: :btree

  create_table "web_comics", force: :cascade do |t|
    t.string   "web_comic_name"
    t.integer  "website_id"
    t.integer  "feed_id"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "web_comics", ["feed_id"], name: "index_web_comics_on_feed_id", using: :btree
  add_index "web_comics", ["identity_id"], name: "index_web_comics_on_identity_id", using: :btree
  add_index "web_comics", ["website_id"], name: "index_web_comics_on_website_id", using: :btree

  create_table "website_domain_registrations", force: :cascade do |t|
    t.integer  "website_domain_id"
    t.integer  "repeat_id"
    t.integer  "periodic_payment_id"
    t.integer  "identity_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "website_domain_registrations", ["identity_id"], name: "index_website_domain_registrations_on_identity_id", using: :btree
  add_index "website_domain_registrations", ["periodic_payment_id"], name: "index_website_domain_registrations_on_periodic_payment_id", using: :btree
  add_index "website_domain_registrations", ["repeat_id"], name: "index_website_domain_registrations_on_repeat_id", using: :btree
  add_index "website_domain_registrations", ["website_domain_id"], name: "index_website_domain_registrations_on_website_domain_id", using: :btree

  create_table "website_domain_ssh_keys", force: :cascade do |t|
    t.integer  "website_domain_id"
    t.integer  "identity_id"
    t.integer  "ssh_key_id"
    t.string   "username"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "website_domain_ssh_keys", ["identity_id"], name: "index_website_domain_ssh_keys_on_identity_id", using: :btree
  add_index "website_domain_ssh_keys", ["ssh_key_id"], name: "index_website_domain_ssh_keys_on_ssh_key_id", using: :btree
  add_index "website_domain_ssh_keys", ["website_domain_id"], name: "index_website_domain_ssh_keys_on_website_domain_id", using: :btree

  create_table "website_domains", force: :cascade do |t|
    t.string   "domain_name"
    t.text     "notes"
    t.integer  "domain_host_id"
    t.integer  "website_id"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "website_domains", ["domain_host_id"], name: "index_website_domains_on_domain_host_id", using: :btree
  add_index "website_domains", ["identity_id"], name: "index_website_domains_on_identity_id", using: :btree
  add_index "website_domains", ["website_id"], name: "index_website_domains_on_website_id", using: :btree

  create_table "website_list_items", force: :cascade do |t|
    t.integer  "website_list_id"
    t.integer  "website_id"
    t.integer  "identity_id"
    t.integer  "position"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "website_list_items", ["identity_id"], name: "index_website_list_items_on_identity_id", using: :btree
  add_index "website_list_items", ["website_id"], name: "index_website_list_items_on_website_id", using: :btree
  add_index "website_list_items", ["website_list_id"], name: "index_website_list_items_on_website_list_id", using: :btree

  create_table "website_lists", force: :cascade do |t|
    t.string   "website_list_name"
    t.text     "notes"
    t.integer  "visit_count"
    t.integer  "identity_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.boolean  "disable_autoload"
    t.integer  "iframe_height"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "website_lists", ["identity_id"], name: "index_website_lists_on_identity_id", using: :btree

  create_table "website_passwords", force: :cascade do |t|
    t.integer  "website_id"
    t.integer  "password_id"
    t.integer  "identity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "website_passwords", ["identity_id"], name: "index_website_passwords_on_identity_id", using: :btree
  add_index "website_passwords", ["password_id"], name: "index_website_passwords_on_password_id", using: :btree
  add_index "website_passwords", ["website_id"], name: "index_website_passwords_on_website_id", using: :btree

  create_table "websites", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.string   "url",              limit: 2000
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.boolean  "to_visit"
    t.integer  "recommender_id"
    t.text     "notes"
    t.string   "website_category"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "websites", ["identity_id"], name: "index_websites_on_identity_id", using: :btree
  add_index "websites", ["recommender_id"], name: "index_websites_on_recommender_id", using: :btree

  create_table "weights", force: :cascade do |t|
    t.decimal  "amount",                   precision: 10, scale: 2
    t.integer  "amount_type"
    t.date     "measure_date"
    t.string   "source",       limit: 255
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "weights", ["identity_id"], name: "index_weights_on_identity_id", using: :btree

  create_table "wisdom_files", force: :cascade do |t|
    t.integer  "wisdom_id"
    t.integer  "identity_file_id"
    t.integer  "identity_id"
    t.integer  "position"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "wisdom_files", ["identity_file_id"], name: "index_wisdom_files_on_identity_file_id", using: :btree
  add_index "wisdom_files", ["identity_id"], name: "index_wisdom_files_on_identity_id", using: :btree
  add_index "wisdom_files", ["wisdom_id"], name: "index_wisdom_files_on_wisdom_id", using: :btree

  create_table "wisdoms", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "notes"
    t.integer  "identity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "visit_count"
    t.datetime "archived"
    t.integer  "rating"
  end

  add_index "wisdoms", ["identity_id"], name: "index_wisdoms_on_identity_id", using: :btree

  add_foreign_key "admin_emails", "emails"
  add_foreign_key "admin_emails", "identities"
  add_foreign_key "admin_text_messages", "identities"
  add_foreign_key "admin_text_messages", "text_messages"
  add_foreign_key "alerts_displays", "identities"
  add_foreign_key "annuities", "identities"
  add_foreign_key "apartment_lease_files", "apartment_leases"
  add_foreign_key "apartment_lease_files", "identities"
  add_foreign_key "apartment_lease_files", "identity_files"
  add_foreign_key "awesome_list_items", "awesome_lists"
  add_foreign_key "awesome_list_items", "identities"
  add_foreign_key "awesome_lists", "identities"
  add_foreign_key "awesome_lists", "locations"
  add_foreign_key "bar_pictures", "bars"
  add_foreign_key "bar_pictures", "identities"
  add_foreign_key "bar_pictures", "identity_files"
  add_foreign_key "bars", "identities"
  add_foreign_key "bars", "locations"
  add_foreign_key "bet_contacts", "bets"
  add_foreign_key "bet_contacts", "contacts"
  add_foreign_key "bet_contacts", "identities"
  add_foreign_key "bets", "identities"
  add_foreign_key "blood_test_files", "blood_tests"
  add_foreign_key "blood_test_files", "identities"
  add_foreign_key "blood_test_files", "identity_files"
  add_foreign_key "blood_tests", "doctors"
  add_foreign_key "blood_tests", "locations"
  add_foreign_key "book_quotes", "books"
  add_foreign_key "book_quotes", "identities"
  add_foreign_key "book_stores", "identities"
  add_foreign_key "book_stores", "locations"
  add_foreign_key "books", "contacts", column: "borrowed_from_id"
  add_foreign_key "books", "contacts", column: "lent_to_id"
  add_foreign_key "business_card_files", "business_cards"
  add_foreign_key "business_card_files", "identities"
  add_foreign_key "business_card_files", "identity_files"
  add_foreign_key "business_cards", "contacts"
  add_foreign_key "business_cards", "identities"
  add_foreign_key "cafes", "identities"
  add_foreign_key "cafes", "locations"
  add_foreign_key "calendar_item_reminder_pendings", "calendar_item_reminders"
  add_foreign_key "calendar_item_reminder_pendings", "calendar_items"
  add_foreign_key "calendar_item_reminder_pendings", "calendars"
  add_foreign_key "calendar_item_reminder_pendings", "identities"
  add_foreign_key "calendar_item_reminders", "calendar_items"
  add_foreign_key "calendar_item_reminders", "identities"
  add_foreign_key "calendar_items", "calendars"
  add_foreign_key "calendar_items", "identities"
  add_foreign_key "charities", "identities"
  add_foreign_key "charities", "locations"
  add_foreign_key "computer_ssh_keys", "computers"
  add_foreign_key "computer_ssh_keys", "identities"
  add_foreign_key "computer_ssh_keys", "ssh_keys"
  add_foreign_key "concert_pictures", "concerts"
  add_foreign_key "concert_pictures", "identities"
  add_foreign_key "concert_pictures", "identity_files"
  add_foreign_key "connections", "contacts"
  add_foreign_key "connections", "identities"
  add_foreign_key "connections", "users"
  add_foreign_key "desired_locations", "identities"
  add_foreign_key "desired_locations", "locations"
  add_foreign_key "desired_locations", "websites"
  add_foreign_key "dessert_locations", "identities"
  add_foreign_key "dessert_locations", "locations"
  add_foreign_key "diary_entries", "encrypted_values", column: "entry_encrypted_id"
  add_foreign_key "drafts", "identities"
  add_foreign_key "dreams", "encrypted_values", column: "dream_encrypted_id"
  add_foreign_key "dreams", "identities"
  add_foreign_key "education_files", "educations"
  add_foreign_key "education_files", "identities"
  add_foreign_key "education_files", "identity_files"
  add_foreign_key "educations", "identities"
  add_foreign_key "educations", "locations"
  add_foreign_key "email_contacts", "contacts"
  add_foreign_key "email_contacts", "emails"
  add_foreign_key "email_contacts", "identities"
  add_foreign_key "email_groups", "emails"
  add_foreign_key "email_groups", "groups"
  add_foreign_key "email_groups", "identities"
  add_foreign_key "email_personalizations", "emails"
  add_foreign_key "email_personalizations", "identities"
  add_foreign_key "email_tokens", "identities"
  add_foreign_key "email_unsubscriptions", "identities"
  add_foreign_key "emails", "identities"
  add_foreign_key "emergency_contacts", "emails"
  add_foreign_key "emergency_contacts", "identities"
  add_foreign_key "event_contacts", "contacts"
  add_foreign_key "event_contacts", "events"
  add_foreign_key "event_contacts", "identities"
  add_foreign_key "event_pictures", "events"
  add_foreign_key "event_pictures", "identities"
  add_foreign_key "event_pictures", "identity_files"
  add_foreign_key "event_rsvps", "events"
  add_foreign_key "event_rsvps", "identities"
  add_foreign_key "exercise_regimen_exercise_files", "exercise_regimen_exercises"
  add_foreign_key "exercise_regimen_exercise_files", "identities"
  add_foreign_key "exercise_regimen_exercise_files", "identity_files"
  add_foreign_key "exercise_regimen_exercises", "exercise_regimens"
  add_foreign_key "exercise_regimen_exercises", "identities"
  add_foreign_key "exercise_regimens", "identities"
  add_foreign_key "favorite_locations", "identities"
  add_foreign_key "favorite_locations", "locations"
  add_foreign_key "favorite_product_files", "favorite_products"
  add_foreign_key "favorite_product_files", "identities"
  add_foreign_key "favorite_product_files", "identity_files"
  add_foreign_key "favorite_product_links", "favorite_products"
  add_foreign_key "favorite_product_links", "identities"
  add_foreign_key "feed_items", "feeds"
  add_foreign_key "feed_items", "identities"
  add_foreign_key "feed_load_statuses", "identities"
  add_foreign_key "flight_legs", "companies", column: "flight_company_id"
  add_foreign_key "flight_legs", "flights"
  add_foreign_key "flight_legs", "identities"
  add_foreign_key "flight_legs", "locations", column: "arrival_location_id"
  add_foreign_key "flight_legs", "locations", column: "depart_location_id"
  add_foreign_key "flights", "identities"
  add_foreign_key "group_references", "groups"
  add_foreign_key "group_references", "groups", column: "parent_group_id"
  add_foreign_key "group_references", "identities"
  add_foreign_key "happy_things", "identities"
  add_foreign_key "hotels", "identities"
  add_foreign_key "hotels", "locations"
  add_foreign_key "identities", "companies"
  add_foreign_key "identities", "identities"
  add_foreign_key "invite_codes", "identities"
  add_foreign_key "invites", "users"
  add_foreign_key "job_files", "identities"
  add_foreign_key "job_files", "identity_files"
  add_foreign_key "job_files", "jobs"
  add_foreign_key "job_managers", "contacts"
  add_foreign_key "job_managers", "identities"
  add_foreign_key "job_managers", "jobs"
  add_foreign_key "job_myreferences", "identities"
  add_foreign_key "job_myreferences", "jobs"
  add_foreign_key "job_myreferences", "myreferences"
  add_foreign_key "job_review_files", "identities"
  add_foreign_key "job_review_files", "identity_files"
  add_foreign_key "job_review_files", "job_reviews"
  add_foreign_key "job_reviews", "contacts"
  add_foreign_key "job_reviews", "identities"
  add_foreign_key "job_reviews", "jobs"
  add_foreign_key "life_highlights", "identities"
  add_foreign_key "location_pictures", "identities"
  add_foreign_key "location_pictures", "identity_files"
  add_foreign_key "location_pictures", "locations"
  add_foreign_key "locations", "websites"
  add_foreign_key "meadows", "identities"
  add_foreign_key "meadows", "locations"
  add_foreign_key "media_dump_files", "identities"
  add_foreign_key "media_dump_files", "identity_files"
  add_foreign_key "media_dump_files", "media_dumps"
  add_foreign_key "media_dumps", "identities"
  add_foreign_key "medical_condition_treatments", "doctors"
  add_foreign_key "medical_condition_treatments", "identities"
  add_foreign_key "medical_condition_treatments", "locations"
  add_foreign_key "medical_condition_treatments", "medical_conditions"
  add_foreign_key "membership_files", "identities"
  add_foreign_key "membership_files", "identity_files"
  add_foreign_key "membership_files", "memberships"
  add_foreign_key "message_contacts", "contacts"
  add_foreign_key "message_contacts", "identities"
  add_foreign_key "message_contacts", "messages"
  add_foreign_key "message_groups", "groups"
  add_foreign_key "message_groups", "identities"
  add_foreign_key "message_groups", "messages"
  add_foreign_key "messages", "identities"
  add_foreign_key "money_balance_item_templates", "identities"
  add_foreign_key "money_balance_item_templates", "money_balances"
  add_foreign_key "money_balance_items", "identities"
  add_foreign_key "money_balance_items", "money_balances"
  add_foreign_key "money_balances", "contacts"
  add_foreign_key "money_balances", "identities"
  add_foreign_key "myreferences", "contacts"
  add_foreign_key "myreferences", "identities"
  add_foreign_key "password_secret_shares", "identities"
  add_foreign_key "password_secret_shares", "password_secrets"
  add_foreign_key "password_secret_shares", "password_shares"
  add_foreign_key "password_shares", "identities"
  add_foreign_key "password_shares", "passwords"
  add_foreign_key "password_shares", "users"
  add_foreign_key "periodic_payments", "passwords"
  add_foreign_key "permission_share_children", "identities"
  add_foreign_key "permission_share_children", "permission_shares"
  add_foreign_key "permission_share_children", "shares"
  add_foreign_key "permission_shares", "emails"
  add_foreign_key "permission_shares", "identities"
  add_foreign_key "permission_shares", "shares"
  add_foreign_key "permissions", "identities"
  add_foreign_key "permissions", "users"
  add_foreign_key "phone_files", "identities"
  add_foreign_key "phone_files", "identity_files"
  add_foreign_key "phone_files", "phones"
  add_foreign_key "playlists", "identity_files"
  add_foreign_key "podcasts", "feeds"
  add_foreign_key "podcasts", "identities"
  add_foreign_key "problem_report_files", "identities"
  add_foreign_key "problem_report_files", "identity_files"
  add_foreign_key "problem_report_files", "problem_reports"
  add_foreign_key "problem_reports", "identities"
  add_foreign_key "project_issue_files", "identities"
  add_foreign_key "project_issue_files", "identity_files"
  add_foreign_key "project_issue_files", "project_issues"
  add_foreign_key "project_issue_notifiers", "contacts"
  add_foreign_key "project_issue_notifiers", "identities"
  add_foreign_key "project_issue_notifiers", "project_issues"
  add_foreign_key "project_issues", "identities"
  add_foreign_key "project_issues", "projects"
  add_foreign_key "projects", "identities"
  add_foreign_key "quest_files", "identities"
  add_foreign_key "quest_files", "identity_files"
  add_foreign_key "quest_files", "quests"
  add_foreign_key "quests", "identities"
  add_foreign_key "receipt_files", "identities"
  add_foreign_key "receipt_files", "identity_files"
  add_foreign_key "receipt_files", "receipts"
  add_foreign_key "receipts", "identities"
  add_foreign_key "recipe_pictures", "identities"
  add_foreign_key "recipe_pictures", "identity_files"
  add_foreign_key "recipe_pictures", "recipes"
  add_foreign_key "restaurant_pictures", "identities"
  add_foreign_key "restaurant_pictures", "identity_files"
  add_foreign_key "restaurant_pictures", "restaurants"
  add_foreign_key "ssh_keys", "encrypted_values", column: "ssh_private_key_encrypted_id"
  add_foreign_key "ssh_keys", "identities"
  add_foreign_key "ssh_keys", "passwords"
  add_foreign_key "stories", "identities"
  add_foreign_key "story_pictures", "identities"
  add_foreign_key "story_pictures", "identity_files"
  add_foreign_key "story_pictures", "stories"
  add_foreign_key "text_message_contacts", "contacts"
  add_foreign_key "text_message_contacts", "identities"
  add_foreign_key "text_message_contacts", "text_messages"
  add_foreign_key "text_message_groups", "groups"
  add_foreign_key "text_message_groups", "identities"
  add_foreign_key "text_message_groups", "text_messages"
  add_foreign_key "text_message_unsubscriptions", "identities"
  add_foreign_key "text_messages", "identities"
  add_foreign_key "timing_events", "identities"
  add_foreign_key "timing_events", "timings"
  add_foreign_key "timings", "identities"
  add_foreign_key "trek_pictures", "identities"
  add_foreign_key "trek_pictures", "identity_files"
  add_foreign_key "trek_pictures", "treks"
  add_foreign_key "treks", "identities"
  add_foreign_key "treks", "locations"
  add_foreign_key "trip_flights", "flights"
  add_foreign_key "trip_flights", "identities"
  add_foreign_key "trip_flights", "trips"
  add_foreign_key "trip_stories", "identities"
  add_foreign_key "trip_stories", "stories"
  add_foreign_key "trip_stories", "trips"
  add_foreign_key "trips", "hotels"
  add_foreign_key "trips", "identity_files"
  add_foreign_key "tv_shows", "contacts", column: "recommender_id"
  add_foreign_key "tv_shows", "identities"
  add_foreign_key "volunteering_activities", "identities"
  add_foreign_key "web_comics", "feeds"
  add_foreign_key "web_comics", "identities"
  add_foreign_key "web_comics", "websites"
  add_foreign_key "website_domain_registrations", "identities"
  add_foreign_key "website_domain_registrations", "periodic_payments"
  add_foreign_key "website_domain_registrations", "repeats"
  add_foreign_key "website_domain_registrations", "website_domains"
  add_foreign_key "website_domain_ssh_keys", "identities"
  add_foreign_key "website_domain_ssh_keys", "ssh_keys"
  add_foreign_key "website_domain_ssh_keys", "website_domains"
  add_foreign_key "website_domains", "identities"
  add_foreign_key "website_domains", "memberships", column: "domain_host_id"
  add_foreign_key "website_domains", "websites"
  add_foreign_key "website_list_items", "identities"
  add_foreign_key "website_list_items", "website_lists"
  add_foreign_key "website_list_items", "websites"
  add_foreign_key "website_lists", "identities"
  add_foreign_key "website_passwords", "identities"
  add_foreign_key "website_passwords", "passwords"
  add_foreign_key "website_passwords", "websites"
  add_foreign_key "websites", "contacts", column: "recommender_id"
  add_foreign_key "wisdom_files", "identities"
  add_foreign_key "wisdom_files", "identity_files"
  add_foreign_key "wisdom_files", "wisdoms"
end
