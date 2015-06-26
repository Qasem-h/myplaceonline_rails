class Identity < ActiveRecord::Base
  belongs_to :owner, class_name: User
  has_many :passwords, :dependent => :destroy
  has_many :identity_files, :dependent => :destroy
  has_many :category_points_amounts, :dependent => :destroy
  has_many :movies, :dependent => :destroy
  has_many :wisdoms, :dependent => :destroy
  has_many :to_dos, :dependent => :destroy
  has_many :contacts, :dependent => :destroy
  has_many :accomplishments, :dependent => :destroy
  has_many :feeds, :dependent => :destroy
  has_many :locations, :dependent => :destroy
  has_many :activities, :dependent => :destroy
  has_many :apartments, :dependent => :destroy
  has_many :jokes, :dependent => :destroy
  has_many :companies, :dependent => :destroy
  has_many :promises, :dependent => :destroy
  has_many :subscriptions, :dependent => :destroy
  has_many :credit_scores, :dependent => :destroy
  has_many :websites, :dependent => :destroy
  has_many :credit_cards, :dependent => :destroy
  has_many :bank_accounts, :dependent => :destroy
  has_many :ideas, :dependent => :destroy
  has_many :lists, :dependent => :destroy
  has_many :calculation_forms, :dependent => :destroy
  has_many :calculations, :dependent => :destroy
  has_many :vehicles, :dependent => :destroy
  has_many :questions, :dependent => :destroy
  has_many :weights, :dependent => :destroy
  has_many :blood_pressures, :dependent => :destroy
  has_many :heart_rates, :dependent => :destroy
  has_many :recipes, :dependent => :destroy
  has_many :sleep_measurements, :dependent => :destroy
  has_many :heights, :dependent => :destroy
  has_many :meals, :dependent => :destroy
  has_many :recreational_vehicles, :dependent => :destroy
  has_many :acne_measurements, :dependent => :destroy
  has_many :exercises, :dependent => :destroy
  has_many :sun_exposures, :dependent => :destroy
  has_many :medicine_usages, :dependent => :destroy
  has_many :pains, :dependent => :destroy
  has_many :songs, :dependent => :destroy
  has_many :blood_tests, :dependent => :destroy
  has_many :checklists, :dependent => :destroy
  has_many :medical_conditions, :dependent => :destroy
  has_many :life_goals, :dependent => :destroy
  has_many :temperatures, :dependent => :destroy
  has_many :headaches, :dependent => :destroy
  has_many :skin_treatments, :dependent => :destroy
  has_many :periodic_payments, :dependent => :destroy
  has_many :jobs, :dependent => :destroy
  has_many :trips, :dependent => :destroy
  has_many :passports, :dependent => :destroy
  has_many :promotions, :dependent => :destroy
  has_many :reward_programs, :dependent => :destroy
  has_many :computers, :dependent => :destroy
  has_many :life_insurances, :dependent => :destroy
  
  has_many :identity_phones, :foreign_key => 'ref_id', :dependent => :destroy
  accepts_nested_attributes_for :identity_phones, allow_destroy: true, reject_if: :all_blank
  
  has_many :identity_emails, :foreign_key => 'ref_id', :dependent => :destroy
  accepts_nested_attributes_for :identity_emails, allow_destroy: true, reject_if: :all_blank
  
  has_many :identity_locations, :foreign_key => 'ref_id', :dependent => :destroy
  accepts_nested_attributes_for :identity_locations, allow_destroy: true, reject_if: :all_blank
  
  def primary_location
    identity_locations.first
  end
  
  has_many :identity_drivers_licenses, :foreign_key => 'ref_id', :dependent => :destroy
  accepts_nested_attributes_for :identity_drivers_licenses, allow_destroy: true, reject_if: proc { |attributes| LocationsController.reject_if_blank(attributes) }
  
  has_many :identity_relationships, :foreign_key => 'ref_id', :dependent => :destroy
  accepts_nested_attributes_for :identity_relationships, allow_destroy: true, reject_if: :all_blank
  
  def as_json(options={})
    super.as_json(options).merge({
      :category_points_amounts => category_points_amounts.to_a.map{|x| x.as_json},
      :passwords => passwords.to_a.sort{ |a,b| a.name.downcase <=> b.name.downcase }.map{|x| x.as_json},
      :movies => movies.to_a.sort{ |a,b| a.name.downcase <=> b.name.downcase }.map{|x| x.as_json},
      :wisdoms => wisdoms.to_a.sort{ |a,b| a.name.downcase <=> b.name.downcase }.map{|x| x.as_json},
      :to_dos => to_dos.to_a.sort{ |a,b| a.short_description.downcase <=> b.short_description.downcase }.map{|x| x.as_json},
      :contacts => contacts.to_a.delete_if{|x| x.ref_id == id }.map{|x| x.as_json},
      :accomplishments => accomplishments.to_a.sort{ |a,b| a.name.downcase <=> b.name.downcase }.map{|x| x.as_json},
      :feeds => feeds.to_a.sort{ |a,b| a.name.downcase <=> b.name.downcase }.map{|x| x.as_json},
      :locations => locations.to_a.sort{ |a,b| a.name.downcase <=> b.name.downcase }.map{|x| x.as_json},
      :activities => activities.to_a.sort{ |a,b| a.name.downcase <=> b.name.downcase }.map{|x| x.as_json},
      :apartments => apartments.to_a.map{|x| x.as_json},
      :jokes => jokes.to_a.sort{ |a,b| a.name.downcase <=> b.name.downcase }.map{|x| x.as_json},
      :companies => companies.to_a.sort{ |a,b| a.name.downcase <=> b.name.downcase }.map{|x| x.as_json},
      :promises => promises.to_a.sort{ |a,b| a.name.downcase <=> b.name.downcase }.map{|x| x.as_json},
      :subscriptions => subscriptions.to_a.sort{ |a,b| a.name.downcase <=> b.name.downcase }.map{|x| x.as_json},
      :credit_scores => credit_scores.to_a.map{|x| x.as_json},
      :websites => websites.to_a.sort{ |a,b| a.title.downcase <=> b.title.downcase }.map{|x| x.as_json},
      :credit_cards => credit_cards.to_a.sort{ |a,b| a.name.downcase <=> b.name.downcase }.map{|x| x.as_json},
      :bank_accounts => bank_accounts.to_a.sort{ |a,b| a.name.downcase <=> b.name.downcase }.map{|x| x.as_json},
      :ideas => ideas.to_a.sort{ |a,b| a.name.downcase <=> b.name.downcase }.map{|x| x.as_json},
      :lists => lists.to_a.sort{ |a,b| a.name.downcase <=> b.name.downcase }.map{|x| x.as_json},
      :calculation_forms => calculation_forms.to_a.sort{ |a,b| a.name.downcase <=> b.name.downcase }.map{|x| x.as_json},
      :calculations => calculations.to_a.sort{ |a,b| a.name.downcase <=> b.name.downcase }.map{|x| x.as_json},
      :vehicles => vehicles.to_a.sort{ |a,b| a.name.downcase <=> b.name.downcase }.map{|x| x.as_json},
      :questions => questions.to_a.sort{ |a,b| a.name.downcase <=> b.name.downcase }.map{|x| x.as_json},
      :weights => weights.to_a.map{|x| x.as_json},
      :blood_pressures => blood_pressures.to_a.map{|x| x.as_json},
      :heart_rates => heart_rates.to_a.map{|x| x.as_json},
      :recipes => recipes.to_a.sort{ |a,b| a.name.downcase <=> b.name.downcase }.map{|x| x.as_json},
      :sleep_measurements => sleep_measurements.to_a.map{|x| x.as_json},
      :heights => heights.to_a.map{|x| x.as_json},
      :meals => meals.to_a.map{|x| x.as_json},
      :recreational_vehicles => recreational_vehicles.to_a.sort{ |a,b| a.rv_name.downcase <=> b.rv_name.downcase }.map{|x| x.as_json},
      :acne_measurements => acne_measurements.to_a.map{|x| x.as_json},
      :exercises => exercises.to_a.map{|x| x.as_json},
      :sun_exposures => sun_exposures.to_a.map{|x| x.as_json},
      :medicine_usages => medicine_usages.to_a.map{|x| x.as_json},
      :pains => pains.to_a.map{|x| x.as_json},
      :songs => songs.to_a.sort{ |a,b| a.song_name.downcase <=> b.song_name.downcase }.map{|x| x.as_json},
      :blood_tests => blood_tests.to_a.map{|x| x.as_json},
      :checklists => checklists.to_a.sort{ |a,b| a.checklist_name.downcase <=> b.checklist_name.downcase }.map{|x| x.as_json},
      :medical_conditions => medical_conditions.to_a.sort{ |a,b| a.medical_condition_name.downcase <=> b.medical_condition_name.downcase }.map{|x| x.as_json},
      :life_goals => life_goals.to_a.sort{ |a,b| a.life_goal_name.downcase <=> b.life_goal_name.downcase }.map{|x| x.as_json},
      :temperatures => temperatures.to_a.map{|x| x.as_json},
      :headaches => headaches.to_a.map{|x| x.as_json},
      :skin_treatments => skin_treatments.to_a.map{|x| x.as_json},
      :periodic_payments => periodic_payments.to_a.sort{ |a,b| a.periodic_payment_name.downcase <=> b.periodic_payment_name.downcase }.map{|x| x.as_json},
      :jobs => jobs.to_a.sort{ |a,b| a.job_title.downcase <=> b.job_title.downcase }.map{|x| x.as_json},
      :trips => trips.to_a.map{|x| x.as_json},
      :passports => passports.to_a.map{|x| x.as_json},
      :promotions => promotions.to_a.sort{ |a,b| a.promotion_name.downcase <=> b.promotion_name.downcase }.map{|x| x.as_json},
      :reward_programs => reward_programs.to_a.sort{ |a,b| a.reward_program_name.downcase <=> b.reward_program_name.downcase }.map{|x| x.as_json},
      :computers => computers.to_a.sort{ |a,b| a.computer_model.downcase <=> b.computer_model.downcase }.map{|x| x.as_json},
      :life_insurances => life_insurances.to_a.sort{ |a,b| a.insurance_name.downcase <=> b.insurance_name.downcase }.map{|x| x.as_json},
      :identity_files => identity_files.to_a.map{|x| x.as_json}
    })
  end
  
  def ensure_contact!
    if Contact.find_by(
      identity_id: id,
      ref_id: id
    ).nil?
      ActiveRecord::Base.transaction do
        me = Contact.new
        if self.name.blank?
          self.name = I18n.t("myplaceonline.contacts.me")
          self.save!
        end
        me.identity = self
        me.ref = self
        me.save!
      end
    end
  end
  
  def last_weight
    weights.to_a.sort{ |a,b| b.measure_date <=> a.measure_date }.first
  end
end
