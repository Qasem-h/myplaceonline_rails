class DueItem < MyplaceonlineIdentityRecord
  
  belongs_to :myplaceonline_due_display

  UPDATE_TYPE_UPDATE = 1
  UPDATE_TYPE_DELETE = 2
  
  DEFAULT_SNOOZE_SECONDS = 60*60*24
  DEFAULT_SNOOZE_TEXT = "1, 00:00:00"
  
  # Should match crontab minimum
  MINIMUM_DURATION_SECONDS = 60*5

  def short_date
    if Date.today.year > due_date.year
      Myp.display_date_short_year(due_date, User.current_user)
    else
      Myp.display_date_short(due_date, User.current_user)
    end
  end
  
  def check_and_save!
    if allows_reminder
      save!
    else
      true
    end
  end
  
  def allows_reminder
    if self.is_date_arbitrary
      ::CompleteDueItem.where(
        owner_id: self.owner_id,
        myplaceonline_due_display_id: self.myplaceonline_due_display.id,
        model_name: self.model_name,
        model_id: self.model_id
      ).length == 0 && ::SnoozedDueItem.where(
        owner_id: self.owner_id,
        myplaceonline_due_display_id: self.myplaceonline_due_display.id,
        model_name: self.model_name,
        model_id: self.model_id
      ).length == 0
    else
      ::CompleteDueItem.where(
        owner_id: self.owner_id,
        myplaceonline_due_display_id: self.myplaceonline_due_display.id,
        due_date: self.original_due_date,
        model_name: self.model_name,
        model_id: self.model_id
      ).length == 0 && ::SnoozedDueItem.where(
        owner_id: self.owner_id,
        myplaceonline_due_display_id: self.myplaceonline_due_display.id,
        original_due_date: self.original_due_date,
        model_name: self.model_name,
        model_id: self.model_id
      ).length == 0
    end
  end
  
  def self.general_threshold
    60.days.from_now
  end
  
  def self.exercise_threshold(mdd)
    (mdd.exercise_threshold || 7).days.ago
  end
  
  def self.timenow
    Time.now
  end
  
  def self.datenow
    Date.today
  end
  
  def self.contact_type_threshold
    result = Hash.new
    result[0] = 20.days.ago
    result[1] = 45.days.ago
    result[2] = 90.days.ago
    result[4] = 20.days.ago
    result[5] = 45.days.ago
    result
  end
  
  def self.dentist_visit_threshold
    5.months.ago
  end
  
  def self.doctor_visit_threshold
    11.months.ago
  end
  
  def self.status_threshold
    16.hours.ago
  end
  
  def self.trash_pickup_threshold
    2
  end
  
  def self.periodic_payment_threshold_after
    2
  end
  
  def self.periodic_payment_threshold_before
    5
  end
  
  def self.all_due(user)
    DueItem.where(owner: user.primary_identity).order(:due_date)
  end
  
  def self.recalculate_due(user)
    ActiveRecord::Base.transaction do
      due_vehicles(user)
      due_contacts(user)
      due_exercises(user)
      due_promotions(user)
      due_gun_registrations(user)
      due_dental_cleanings(user)
      due_physicals(user)
      due_status(user)
      due_apartments(user)
      due_periodic_payments(user)
    end
  end

  # This will be called periodically by crontab
  def self.recalculate_all_users_due()
    User.all.each do |user|
      begin
        User.current_user = user
        self.recalculate_due(user)
      ensure
        User.current_user = nil
      end
    end
  end
  
  def self.check_snoozed_items(user, model_name, updated_record, update_type)
    if !updated_record.nil? && !update_type.nil? && update_type == DueItem::UPDATE_TYPE_DELETE
      ::SnoozedDueItem.where(owner: user.primary_identity, model_name: model_name, model_id: updated_record.id).each do |snoozed_item|
        snoozed_item.destroy!
      end
    end
    
    ::SnoozedDueItem.where(owner: user.primary_identity, model_name: model_name).where("due_date <= ?", timenow).each do |snoozed_item|
      DueItem.new(
        display: snoozed_item.display,
        link: snoozed_item.link,
        due_date: snoozed_item.due_date,
        original_due_date: snoozed_item.original_due_date,
        owner_id: snoozed_item.owner_id,
        myplaceonline_due_display: snoozed_item.myplaceonline_due_display,
        model_name: snoozed_item.model_name,
        model_id: snoozed_item.model_id
      ).save!
    end
  end

  def self.due_vehicles(user, updated_record = nil, update_type = nil)
    DueItem.destroy_all(owner: user.primary_identity, model_name: Vehicle.name)
    
    user.primary_identity.myplaceonline_due_displays.each do |mdd|
      Vehicle.where(owner: user.primary_identity).each do |vehicle|
        vehicle.vehicle_services.each do |service|
          if service.date_serviced.nil? && !service.date_due.nil?
            DueItem.new(
              display: service.short_description,
              link: "/vehicles/" + vehicle.id.to_s,
              due_date: service.date_due,
              original_due_date: service.date_due,
              owner: user.primary_identity,
              myplaceonline_due_display: mdd,
              model_name: Vehicle.name,
              model_id: vehicle.id
            ).check_and_save!
          end
        end
      end
    end
    
    check_snoozed_items(user, Vehicle.name, updated_record, update_type)
  end
  
  def self.due_contacts(user, updated_record = nil, update_type = nil)
    DueItem.destroy_all(owner: user.primary_identity, model_name: Contact.name)
    
    user.primary_identity.myplaceonline_due_displays.each do |mdd|
      IdentityDriversLicense.where("owner_id = ? and expires is not null and expires < ?", user.primary_identity, general_threshold).each do |drivers_license|
        contact = Contact.where(owner_id: user.primary_identity.id, identity_id: drivers_license.identity.id).first
        diff = TimeDifference.between(timenow, drivers_license.expires)
        if timenow >= drivers_license.expires
          # TODO expired
        end
        diff_in_general = diff.in_general
        DueItem.new(
          display: I18n.t(
            "myplaceonline.identities.license_expiring",
            license: drivers_license.display,
            time: Myp.time_difference_in_general_human(diff_in_general)
          ),
          link: "/contacts/" + contact.id.to_s,
          due_date: drivers_license.expires,
          original_due_date: drivers_license.expires,
          owner: user.primary_identity,
          myplaceonline_due_display: mdd,
          model_name: Contact.name,
          model_id: contact.id
        ).check_and_save!
      end

      Contact.where(owner: user.primary_identity).includes(:identity).to_a.each do |x|
        if !x.identity.nil? && !x.identity.birthday.nil?
          bday_this_year = Date.new(Date.today.year, x.identity.birthday.month, x.identity.birthday.day)
          if bday_this_year >= datenow && bday_this_year <= general_threshold
            diff = TimeDifference.between(datenow, bday_this_year)
            diff_in_general = diff.in_general
            DueItem.new(
              display: I18n.t(
                "myplaceonline.contacts.upcoming_birthday",
                name: x.display,
                delta: Myp.time_difference_in_general_human(diff_in_general)
              ),
              link: "/contacts/" + x.id.to_s,
              due_date: bday_this_year,
              original_due_date: bday_this_year,
              owner: user.primary_identity,
              myplaceonline_due_display: mdd,
              model_name: Contact.name,
              model_id: x.id
            ).check_and_save!
          end
        end
      end

      Contact.find_by_sql(%{
        SELECT contacts.*, max(conversations.conversation_date) as last_conversation_date
        FROM contacts
        LEFT OUTER JOIN conversations
          ON contacts.id = conversations.contact_id
        WHERE contacts.owner_id = #{user.primary_identity.id}
          AND contacts.contact_type IS NOT NULL
        GROUP BY contacts.id
        ORDER BY last_conversation_date ASC
      }).each do |contact|
        contact_threshold = contact_type_threshold[contact.contact_type]
        if !contact_threshold.nil?
          if contact.last_conversation_date.nil?
            # No conversations at all
            DueItem.new(
              display: I18n.t(
                "myplaceonline.contacts.no_conversations",
                name: contact.display,
                contact_type: Myp.get_select_name(contact.contact_type, Contact::CONTACT_TYPES)
              ),
              link: "/contacts/" + contact.id.to_s,
              due_date: datenow,
              original_due_date: datenow,
              owner: user.primary_identity,
              myplaceonline_due_display: mdd,
              model_name: Contact.name,
              model_id: contact.id,
              is_date_arbitrary: true
            ).check_and_save!
          else
            if contact.last_conversation_date < contact_threshold
              DueItem.new(
                display: I18n.t(
                  "myplaceonline.contacts.no_conversations_since",
                  name: contact.display,
                  contact_type: Myp.get_select_name(contact.contact_type, Contact::CONTACT_TYPES),
                  delta: Myp.time_difference_in_general_human(TimeDifference.between(datenow, contact.last_conversation_date).in_general)
                ),
                link: "/contacts/" + contact.id.to_s,
                due_date: contact.last_conversation_date,
                original_due_date: contact.last_conversation_date,
                owner: user.primary_identity,
                myplaceonline_due_display: mdd,
                model_name: Contact.name,
                model_id: contact.id
              ).check_and_save!
            end
          end
        end
      end
    end

    check_snoozed_items(user, Contact.name, updated_record, update_type)
  end
  
  def self.due_exercises(user, updated_record = nil, update_type = nil)
    DueItem.destroy_all(owner: user.primary_identity, model_name: Exercise.name)
    
    user.primary_identity.myplaceonline_due_displays.each do |mdd|
      threshold = exercise_threshold(mdd)
      last_exercise = Exercise.where("owner_id = ? and exercise_start is not null", user.primary_identity).order('exercise_start DESC').limit(1).first
      if !last_exercise.nil? and last_exercise.exercise_start < threshold
        DueItem.new(
          display: I18n.t(
            "myplaceonline.exercises.havent_exercised_for",
            delta: Myp.time_difference_in_general_human(TimeDifference.between(timenow, last_exercise.exercise_start).in_general)
          ),
          link: "/exercises/new",
          due_date: last_exercise.exercise_start,
          original_due_date: last_exercise.exercise_start,
          owner: user.primary_identity,
          myplaceonline_due_display: mdd,
          model_name: Exercise.name
        ).check_and_save!
      end
    end

    check_snoozed_items(user, Exercise.name, updated_record, update_type)
  end
  
  def self.due_promotions(user, updated_record = nil, update_type = nil)
    DueItem.destroy_all(owner: user.primary_identity, model_name: Promotion.name)
    
    user.primary_identity.myplaceonline_due_displays.each do |mdd|
      Promotion.where("owner_id = ? and expires is not null and expires > ? and expires < ?", user.primary_identity, datenow, general_threshold).each do |promotion|
        DueItem.new(
          display: I18n.t(
            "myplaceonline.promotions.expires_soon",
            promotion_name: promotion.promotion_name,
            promotion_amount: Myp.number_to_currency(promotion.promotion_amount.nil? ? 0 : promotion.promotion_amount),
            expires_when: Myp.time_difference_in_general_human(TimeDifference.between(timenow, promotion.expires).in_general)
          ),
          link: "/promotions/" + promotion.id.to_s,
          due_date: promotion.expires,
          original_due_date: promotion.expires,
          owner: user.primary_identity,
          myplaceonline_due_display: mdd,
          model_name: Promotion.name,
          model_id: promotion.id
        ).check_and_save!
      end
    end
    
    check_snoozed_items(user, Promotion.name, updated_record, update_type)
  end
  
  def self.due_gun_registrations(user, updated_record = nil, update_type = nil)
    DueItem.destroy_all(owner: user.primary_identity, model_name: GunRegistration.name)
    
    user.primary_identity.myplaceonline_due_displays.each do |mdd|
      GunRegistration.where("owner_id = ? and expires is not null and expires > ? and expires < ?", user.primary_identity, datenow, general_threshold).each do |x|
        DueItem.new(
          display: I18n.t(
            "myplaceonline.gun_registrations.expires_soon",
            gun_name: x.gun.display,
            delta: Myp.time_difference_in_general_human(TimeDifference.between(timenow, x.expires).in_general)
          ),
          link: "/guns/" + x.gun.id.to_s,
          due_date: x.expires,
          original_due_date: x.expires,
          owner: user.primary_identity,
          myplaceonline_due_display: mdd,
          model_name: GunRegistration.name,
          model_id: x.gun.id
        ).check_and_save!
      end
    end

    check_snoozed_items(user, GunRegistration.name, updated_record, update_type)
  end
  
  def self.due_dental_cleanings(user, updated_record = nil, update_type = nil)
    DueItem.destroy_all(owner: user.primary_identity, model_name: DentistVisit.name)
    
    user.primary_identity.myplaceonline_due_displays.each do |mdd|
      last_dentist_visit = DentistVisit.where("owner_id = ? and cleaning = true", user.primary_identity).order('visit_date DESC').limit(1).first
      if !last_dentist_visit.nil? and last_dentist_visit.visit_date < dentist_visit_threshold
        DueItem.new(
          display: I18n.t(
            "myplaceonline.dentist_visits.no_cleaning_for",
            delta: Myp.time_difference_in_general_human(TimeDifference.between(timenow, last_dentist_visit.visit_date).in_general)
          ),
          link: "/dentist_visits/" + last_dentist_visit.id.to_s,
          due_date: last_dentist_visit.visit_date,
          original_due_date: last_dentist_visit.visit_date,
          owner: user.primary_identity,
          myplaceonline_due_display: mdd,
          model_name: DentistVisit.name,
          model_id: last_dentist_visit.id
        ).check_and_save!
      elsif last_dentist_visit.nil?
        # If there are no dentist visits at all but there is a dental insurance company, then notify
        if DentalInsurance.where("owner_id = ? and (defunct is null)", user.primary_identity).count > 0
          DueItem.new(
            display: I18n.t(
              "myplaceonline.dentist_visits.no_cleanings"
            ),
            link: "/dentist_visits/new",
            due_date: timenow,
            original_due_date: timenow,
            owner: user.primary_identity,
            myplaceonline_due_display: mdd,
            model_name: DentistVisit.name,
            is_date_arbitrary: true
          ).check_and_save!
        end
      end
    end
    
    check_snoozed_items(user, DentistVisit.name, updated_record, update_type)
  end
  
  def self.due_physicals(user, updated_record = nil, update_type = nil)
    DueItem.destroy_all(owner: user.primary_identity, model_name: DoctorVisit.name)
    
    user.primary_identity.myplaceonline_due_displays.each do |mdd|
      last_doctor_visit = DoctorVisit.where("owner_id = ? and physical = true", user.primary_identity).order('visit_date DESC').limit(1).first
      if !last_doctor_visit.nil? and last_doctor_visit.visit_date < doctor_visit_threshold
        DueItem.new(
          display: I18n.t(
            "myplaceonline.doctor_visits.no_physical_for",
            delta: Myp.time_difference_in_general_human(TimeDifference.between(timenow, last_doctor_visit.visit_date).in_general)
          ),
          link: "/doctor_visits/" + last_doctor_visit.id.to_s,
          due_date: last_doctor_visit.visit_date,
          original_due_date: last_doctor_visit.visit_date,
          owner: user.primary_identity,
          myplaceonline_due_display: mdd,
          model_name: DoctorVisit.name,
          model_id: last_doctor_visit.id
        ).check_and_save!
      elsif last_doctor_visit.nil?
        # If there are no physicals at all but there is a health insurance company, then notify
        if HealthInsurance.where("owner_id = ? and (defunct is null)", user.primary_identity).count > 0
          DueItem.new(
            display: I18n.t(
              "myplaceonline.doctor_visits.no_physicals"
            ),
            link: "/doctor_visits/new",
            due_date: timenow,
            original_due_date: timenow,
            owner: user.primary_identity,
            myplaceonline_due_display: mdd,
            model_name: DoctorVisit.name,
            is_date_arbitrary: true
          ).check_and_save!
        end
      end
    end

    check_snoozed_items(user, DoctorVisit.name, updated_record, update_type)
  end
  
  def self.due_status(user, updated_record = nil, update_type = nil)
    DueItem.destroy_all(owner: user.primary_identity, model_name: Status.name)
    
    user.primary_identity.myplaceonline_due_displays.each do |mdd|
      last_status = Status.where("owner_id = ?", user.primary_identity).order('status_time DESC').limit(1).first
      if !last_status.nil? and last_status.status_time < status_threshold
        DueItem.new(
          display: I18n.t(
            "myplaceonline.statuses.no_recent_status",
            delta: Myp.time_difference_in_general_human(TimeDifference.between(timenow, last_status.status_time).in_general)
          ),
          link: "/statuses/new",
          due_date: last_status.status_time,
          original_due_date: last_status.status_time,
          owner: user.primary_identity,
          myplaceonline_due_display: mdd,
          model_name: Status.name,
          model_id: last_status.id
        ).check_and_save!
      elsif last_status.nil?
        DueItem.new(
          display: I18n.t(
            "myplaceonline.statuses.no_statuses"
          ),
          link: "/statuses/new",
          due_date: timenow,
          original_due_date: timenow,
          owner: user.primary_identity,
          myplaceonline_due_display: mdd,
          model_name: Status.name,
          is_date_arbitrary: true
        ).check_and_save!
      end
    end

    check_snoozed_items(user, Status.name, updated_record, update_type)
  end
  
  def self.due_apartments(user, updated_record = nil, update_type = nil)
    DueItem.destroy_all(owner: user.primary_identity, model_name: Apartment.name)
    
    epoch = Date.new(1970, 1, 1)
    today_days_from_epoch = (Date.today - epoch).to_i

    user.primary_identity.myplaceonline_due_displays.each do |mdd|
      Apartment.where("owner_id = ?", user.primary_identity).each do |apartment|
        apartment.apartment_trash_pickups.each do |trash_pickup|
          next_pickup = trash_pickup.next_pickup
          if (next_pickup - epoch).to_i - today_days_from_epoch <= trash_pickup_threshold
            DueItem.new(
              display: I18n.t(
                "myplaceonline.apartments.trash_pickup_reminder",
                trash_type: Myp.get_select_name(trash_pickup.trash_type, ApartmentTrashPickup::TRASH_TYPES),
                delta: Myp.time_difference_in_general_human(TimeDifference.between(Date.today, next_pickup).in_general)
              ),
              link: "/apartments/" + apartment.id.to_s,
              due_date: next_pickup,
              original_due_date: next_pickup,
              owner: user.primary_identity,
              myplaceonline_due_display: mdd,
              model_name: Apartment.name,
              model_id: apartment.id
            ).check_and_save!
          end
        end
      end
    end
    
    check_snoozed_items(user, Apartment.name, updated_record, update_type)
  end
  
  def self.due_periodic_payments(user, updated_record = nil, update_type = nil)
    DueItem.destroy_all(owner: user.primary_identity, model_name: PeriodicPayment.name)
    
    today = Date.today
    
    user.primary_identity.myplaceonline_due_displays.each do |mdd|
      PeriodicPayment.where("owner_id = ? and date_period is not null and ended is null", user.primary_identity).each do |x|
        result = nil
        if !x.started.nil?
          result = x.started
        elsif x.date_period == 0
          result = Date.new(today.year, today.month)
        elsif x.date_period == 1
          result = Date.new(today.year)
        end
        if !result.nil?
          while result < today
            if x.date_period == 0
              result = result.advance(months: 1)
            elsif x.date_period == 1
              result = result.advance(years: 1)
            elsif x.date_period == 2
              result = result.advance(months: 6)
            end
          end
          y = result - today
          if y.floor == 0
            DueItem.new(
              display: I18n.t(
                "myplaceonline.periodic_payments.reminder_today",
                name: x.display
              ),
              link: "/periodic_payments/" + x.id.to_s,
              due_date: result,
              original_due_date: result,
              owner: user.primary_identity,
              myplaceonline_due_display: mdd,
              model_name: PeriodicPayment.name,
              model_id: x.id
            ).check_and_save!
          elsif y.floor <= self.periodic_payment_threshold_before
            DueItem.new(
              display: I18n.t(
                "myplaceonline.periodic_payments.reminder_before",
                name: x.display,
                delta: Myp.time_difference_in_general_human(TimeDifference.between(result, today).in_general)
              ),
              link: "/periodic_payments/" + x.id.to_s,
              due_date: result,
              original_due_date: result,
              owner: user.primary_identity,
              myplaceonline_due_display: mdd,
              model_name: PeriodicPayment.name,
              model_id: x.id
            ).check_and_save!
          else
            if x.date_period == 0
              result = result.advance(months: -1)
            elsif x.date_period == 1
              result = result.advance(years: -1)
            elsif x.date_period == 2
              result = result.advance(months: -6)
            end
            y = today - result
            if y.ceil <= self.periodic_payment_threshold_after
              DueItem.new(
                display: I18n.t(
                  "myplaceonline.periodic_payments.reminder_after",
                  name: x.display,
                  delta: Myp.time_difference_in_general_human(TimeDifference.between(result, today).in_general)
                ),
                link: "/periodic_payments/" + x.id.to_s,
                due_date: result,
                original_due_date: result,
                owner: user.primary_identity,
                myplaceonline_due_display: mdd,
                model_name: PeriodicPayment.name,
                model_id: x.id
              ).check_and_save!
            end
          end
        end
      end
    end

    check_snoozed_items(user, PeriodicPayment.name, updated_record, update_type)
  end
  
  # Reminder: When adding a new type of due item processing, consider
  # if the model should have after_save/after_destroy processing to 
  # recalculate due items
end
