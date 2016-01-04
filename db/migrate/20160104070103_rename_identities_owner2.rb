class RenameIdentitiesOwner2 < ActiveRecord::Migration
  def change
    rename_column :accomplishments, :owner_id, :identity_id
    rename_column :acne_measurement_pictures, :owner_id, :identity_id
    rename_column :acne_measurements, :owner_id, :identity_id
    rename_column :activities, :owner_id, :identity_id
    rename_column :apartment_leases, :owner_id, :identity_id
    rename_column :apartment_pictures, :owner_id, :identity_id
    rename_column :apartment_trash_pickups, :owner_id, :identity_id
    rename_column :apartments, :owner_id, :identity_id
    rename_column :bank_accounts, :owner_id, :identity_id
    rename_column :bar_pictures, :owner_id, :identity_id
    rename_column :bars, :owner_id, :identity_id
    rename_column :blood_concentrations, :owner_id, :identity_id
    rename_column :blood_pressures, :owner_id, :identity_id
    rename_column :blood_test_results, :owner_id, :identity_id
    rename_column :blood_tests, :owner_id, :identity_id
    rename_column :books, :owner_id, :identity_id
    rename_column :calculation_elements, :owner_id, :identity_id
    rename_column :calculation_forms, :owner_id, :identity_id
    rename_column :calculation_inputs, :owner_id, :identity_id
    rename_column :calculation_operands, :owner_id, :identity_id
    rename_column :calculations, :owner_id, :identity_id
    rename_column :camp_locations, :owner_id, :identity_id
    rename_column :cashbacks, :owner_id, :identity_id
    rename_column :category_points_amounts, :owner_id, :identity_id
    rename_column :checklist_items, :owner_id, :identity_id
    rename_column :checklist_references, :owner_id, :identity_id
    rename_column :checklists, :owner_id, :identity_id
    rename_column :companies, :owner_id, :identity_id
    rename_column :complete_due_items, :owner_id, :identity_id
    rename_column :computers, :owner_id, :identity_id
    rename_column :concert_musical_groups, :owner_id, :identity_id
    rename_column :concert_pictures, :owner_id, :identity_id
    rename_column :concerts, :owner_id, :identity_id
    rename_column :contacts, :owner_id, :identity_id
    rename_column :conversations, :owner_id, :identity_id
    rename_column :credit_card_cashbacks, :owner_id, :identity_id
    rename_column :credit_cards, :owner_id, :identity_id
    rename_column :credit_scores, :owner_id, :identity_id
    rename_column :date_locations, :owner_id, :identity_id
    rename_column :dental_insurances, :owner_id, :identity_id
    rename_column :dentist_visits, :owner_id, :identity_id
    rename_column :desired_products, :owner_id, :identity_id
    rename_column :diary_entries, :owner_id, :identity_id
    rename_column :doctor_visits, :owner_id, :identity_id
    rename_column :doctors, :owner_id, :identity_id
    rename_column :drinks, :owner_id, :identity_id
    rename_column :due_items, :owner_id, :identity_id
    rename_column :event_pictures, :owner_id, :identity_id
    rename_column :events, :owner_id, :identity_id
    rename_column :exercises, :owner_id, :identity_id
    rename_column :favorite_product_links, :owner_id, :identity_id
    rename_column :favorite_products, :owner_id, :identity_id
    rename_column :feeds, :owner_id, :identity_id
    rename_column :food_ingredients, :owner_id, :identity_id
    rename_column :foods, :owner_id, :identity_id
    rename_column :gas_stations, :owner_id, :identity_id
    rename_column :group_contacts, :owner_id, :identity_id
    rename_column :groups, :owner_id, :identity_id
    rename_column :gun_registrations, :owner_id, :identity_id
    rename_column :guns, :owner_id, :identity_id
    rename_column :headaches, :owner_id, :identity_id
    rename_column :health_insurances, :owner_id, :identity_id
    rename_column :heart_rates, :owner_id, :identity_id
    rename_column :heights, :owner_id, :identity_id
    rename_column :hobbies, :owner_id, :identity_id
    rename_column :hypotheses, :owner_id, :identity_id
    rename_column :hypothesis_experiments, :owner_id, :identity_id
    rename_column :ideas, :owner_id, :identity_id
    rename_column :identity_drivers_licenses, :owner_id, :identity_id
    rename_column :identity_emails, :owner_id, :identity_id
    rename_column :identity_file_folders, :owner_id, :identity_id
    rename_column :identity_file_shares, :owner_id, :identity_id
    rename_column :identity_files, :owner_id, :identity_id
    rename_column :identity_locations, :owner_id, :identity_id
    rename_column :identity_phones, :owner_id, :identity_id
    rename_column :identity_pictures, :owner_id, :identity_id
    rename_column :identity_relationships, :owner_id, :identity_id
    rename_column :job_salaries, :owner_id, :identity_id
    rename_column :jobs, :owner_id, :identity_id
    rename_column :jokes, :owner_id, :identity_id
    rename_column :life_goals, :owner_id, :identity_id
    rename_column :life_insurances, :owner_id, :identity_id
    rename_column :list_items, :owner_id, :identity_id
    rename_column :lists, :owner_id, :identity_id
    rename_column :loans, :owner_id, :identity_id
    rename_column :location_phones, :owner_id, :identity_id
    rename_column :locations, :owner_id, :identity_id
    rename_column :meal_drinks, :owner_id, :identity_id
    rename_column :meal_foods, :owner_id, :identity_id
    rename_column :meal_vitamins, :owner_id, :identity_id
    rename_column :meals, :owner_id, :identity_id
    rename_column :medical_condition_instances, :owner_id, :identity_id
    rename_column :medical_conditions, :owner_id, :identity_id
    rename_column :medicine_usage_medicines, :owner_id, :identity_id
    rename_column :medicine_usages, :owner_id, :identity_id
    rename_column :medicines, :owner_id, :identity_id
    rename_column :memberships, :owner_id, :identity_id
    rename_column :money_balance_items, :owner_id, :identity_id
    rename_column :money_balances, :owner_id, :identity_id
    rename_column :movie_theaters, :owner_id, :identity_id
    rename_column :movies, :owner_id, :identity_id
    rename_column :museums, :owner_id, :identity_id
    rename_column :musical_groups, :owner_id, :identity_id
    rename_column :myplaceonline_due_displays, :owner_id, :identity_id
    rename_column :myplaceonline_quick_category_displays, :owner_id, :identity_id
    rename_column :myplaceonline_searches, :owner_id, :identity_id
    rename_column :myplets, :owner_id, :identity_id
    rename_column :notepads, :owner_id, :identity_id
    rename_column :pains, :owner_id, :identity_id
    rename_column :passport_pictures, :owner_id, :identity_id
    rename_column :passports, :owner_id, :identity_id
    rename_column :password_secrets, :owner_id, :identity_id
    rename_column :passwords, :owner_id, :identity_id
    rename_column :periodic_payments, :owner_id, :identity_id
    rename_column :permissions, :owner_id, :identity_id
    rename_column :phones, :owner_id, :identity_id
    rename_column :playlist_share_contacts, :owner_id, :identity_id
    rename_column :playlist_shares, :owner_id, :identity_id
    rename_column :playlist_songs, :owner_id, :identity_id
    rename_column :playlists, :owner_id, :identity_id
    rename_column :poems, :owner_id, :identity_id
    rename_column :point_displays, :owner_id, :identity_id
    rename_column :promises, :owner_id, :identity_id
    rename_column :promotions, :owner_id, :identity_id
    rename_column :questions, :owner_id, :identity_id
    rename_column :recipes, :owner_id, :identity_id
    rename_column :recreational_vehicle_insurances, :owner_id, :identity_id
    rename_column :recreational_vehicle_loans, :owner_id, :identity_id
    rename_column :recreational_vehicle_measurements, :owner_id, :identity_id
    rename_column :recreational_vehicle_pictures, :owner_id, :identity_id
    rename_column :recreational_vehicles, :owner_id, :identity_id
    rename_column :repeats, :owner_id, :identity_id
    rename_column :restaurant_pictures, :owner_id, :identity_id
    rename_column :restaurants, :owner_id, :identity_id
    rename_column :reward_programs, :owner_id, :identity_id
    rename_column :shares, :owner_id, :identity_id
    rename_column :shopping_list_items, :owner_id, :identity_id
    rename_column :shopping_lists, :owner_id, :identity_id
    rename_column :skin_treatments, :owner_id, :identity_id
    rename_column :sleep_measurements, :owner_id, :identity_id
    rename_column :snoozed_due_items, :owner_id, :identity_id
    rename_column :songs, :owner_id, :identity_id
    rename_column :statuses, :owner_id, :identity_id
    rename_column :stocks, :owner_id, :identity_id
    rename_column :sun_exposures, :owner_id, :identity_id
    rename_column :temperatures, :owner_id, :identity_id
    rename_column :therapists, :owner_id, :identity_id
    rename_column :to_dos, :owner_id, :identity_id
    rename_column :trek_pictures, :owner_id, :identity_id
    rename_column :treks, :owner_id, :identity_id
    rename_column :trip_pictures, :owner_id, :identity_id
    rename_column :trips, :owner_id, :identity_id
    rename_column :vehicle_insurances, :owner_id, :identity_id
    rename_column :vehicle_loans, :owner_id, :identity_id
    rename_column :vehicle_pictures, :owner_id, :identity_id
    rename_column :vehicle_services, :owner_id, :identity_id
    rename_column :vehicle_warranties, :owner_id, :identity_id
    rename_column :vehicles, :owner_id, :identity_id
    rename_column :vitamin_ingredients, :owner_id, :identity_id
    rename_column :vitamins, :owner_id, :identity_id
    rename_column :warranties, :owner_id, :identity_id
    rename_column :websites, :owner_id, :identity_id
    rename_column :weights, :owner_id, :identity_id
    rename_column :wisdoms, :owner_id, :identity_id
  end
end
