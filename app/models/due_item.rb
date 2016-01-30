class DueItem < ActiveRecord::Base
  include MyplaceonlineActiveRecordIdentityConcern
  
  belongs_to :calendar

  UPDATE_TYPE_UPDATE = 1
  UPDATE_TYPE_DELETE = 2
  
  DEFAULT_SNOOZE_SECONDS = 60*60*24
  DEFAULT_SNOOZE_TEXT = "1, 00:00:00"
  
  # Should match crontab minimum
  MINIMUM_DURATION_SECONDS = 60*5
  
  DEFAULT_EXERCISE_THRESHOLD_SECONDS = 7*60*60*24
  
  DEFAULT_CONTACT_BEST_FRIEND_THRESHOLD_SECONDS = 20*60*60*24
  DEFAULT_CONTACT_GOOD_FRIEND_THRESHOLD_SECONDS = 45*60*60*24
  DEFAULT_CONTACT_ACQUAINTANCE_THRESHOLD_SECONDS = 90*60*60*24
  DEFAULT_CONTACT_BEST_FAMILY_THRESHOLD_SECONDS = 20*60*60*24
  DEFAULT_CONTACT_GOOD_FAMILY_THRESHOLD_SECONDS = 45*60*60*24

  DEFAULT_DOCTOR_VISIT_THRESHOLD_SECONDS = 11*4*5*60*60*24
  DEFAULT_STATUS_THRESHOLD_SECONDS = 60*60*16
  DEFAULT_TRASH_PICKUP_THRESHOLD_SECONDS = 2*60*60*24
  DEFAULT_PERIODIC_PAYMENT_BEFORE_THRESHOLD_SECONDS = 3*60*60*24
  DEFAULT_PERIODIC_PAYMENT_AFTER_THRESHOLD_SECONDS = 3*60*60*24

  DEFAULT_DRIVERS_LICENSE_EXPIRATION_THRESHOLD_SECONDS = 60*60*60*24
  DEFAULT_BIRTHDAY_THRESHOLD_SECONDS = 60*60*60*24
  DEFAULT_PROMOTION_THRESHOLD_SECONDS = 60*60*60*24
  DEFAULT_GUN_REGISTRATION_EXPIRATION_THRESHOLD_SECONDS = 60*60*60*24
  DEFAULT_EVENT_THRESHOLD_SECONDS = 30*60*60*24
  DEFAULT_STOCKS_VEST_THRESHOLD_SECONDS = 30*60*60*24
  DEFAULT_TODO_THRESHOLD_SECONDS = 7*60*60*24

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
    Rails.logger.debug{
      "allows_reminder start, #{self.inspect}"
    }
    if self.is_date_arbitrary
      completed_due_items = ::CompleteDueItem.where(
        identity_id: self.identity_id,
        calendar_id: self.calendar.id,
        myp_model_name: self.myp_model_name,
        model_id: self.model_id
      )
      
      snoozed_due_items = ::SnoozedDueItem.where(
        identity_id: self.identity_id,
        calendar_id: self.calendar.id,
        myp_model_name: self.myp_model_name,
        model_id: self.model_id
      )
    else
      completed_due_items = ::CompleteDueItem.where(
        identity_id: self.identity_id,
        calendar_id: self.calendar.id,
        due_date: self.original_due_date,
        myp_model_name: self.myp_model_name,
        model_id: self.model_id
      )
      
      snoozed_due_items = ::SnoozedDueItem.where(
        identity_id: self.identity_id,
        calendar_id: self.calendar.id,
        original_due_date: self.original_due_date,
        myp_model_name: self.myp_model_name,
        model_id: self.model_id
      )
    end
    
    Rails.logger.debug{
      "allows_reminder end, completed_due_items: #{
        completed_due_items.length
      }, snoozed_due_items: #{
        snoozed_due_items.length
      }"
    }
    
    completed_due_items.length == 0 && snoozed_due_items.length == 0
  end
  
  def self.exercise_threshold(calendar)
    (calendar.exercise_threshold_seconds || DEFAULT_EXERCISE_THRESHOLD_SECONDS).seconds.ago
  end
  
  def self.timenow
    Time.now
  end
  
  def self.datenow
    Date.today
  end
  
  def self.contact_type_threshold(calendar)
    result = Hash.new
    result[0] = (calendar.contact_best_friend_threshold_seconds || DEFAULT_CONTACT_BEST_FRIEND_THRESHOLD_SECONDS).seconds.ago
    result[1] = (calendar.contact_good_friend_threshold_seconds || DEFAULT_CONTACT_GOOD_FRIEND_THRESHOLD_SECONDS).seconds.ago
    result[2] = (calendar.contact_acquaintance_threshold_seconds || DEFAULT_CONTACT_ACQUAINTANCE_THRESHOLD_SECONDS).seconds.ago
    result[4] = (calendar.contact_best_family_threshold_seconds || DEFAULT_CONTACT_BEST_FAMILY_THRESHOLD_SECONDS).seconds.ago
    result[5] = (calendar.contact_good_family_threshold_seconds || DEFAULT_CONTACT_GOOD_FAMILY_THRESHOLD_SECONDS).seconds.ago
    result
  end
  
  def self.doctor_visit_threshold(calendar)
    (calendar.doctor_visit_threshold_seconds || DEFAULT_DOCTOR_VISIT_THRESHOLD_SECONDS).seconds.ago
  end
  
  def self.status_threshold(calendar)
    (calendar.status_threshold_seconds || DEFAULT_STATUS_THRESHOLD_SECONDS).seconds.ago
  end

  def self.drivers_license_expiration_threshold(calendar)
    (calendar.drivers_license_expiration_threshold_seconds || DEFAULT_DRIVERS_LICENSE_EXPIRATION_THRESHOLD_SECONDS).seconds.since
  end
  
  def self.birthday_threshold(calendar)
    (calendar.birthday_threshold_seconds || DEFAULT_BIRTHDAY_THRESHOLD_SECONDS).seconds.since
  end
  
  def self.promotion_threshold(calendar)
    (calendar.promotion_threshold_seconds || DEFAULT_PROMOTION_THRESHOLD_SECONDS).seconds.since
  end
  
  def self.gun_registration_expiration_threshold(calendar)
    (calendar.gun_registration_expiration_threshold_seconds || DEFAULT_GUN_REGISTRATION_EXPIRATION_THRESHOLD_SECONDS).seconds.since
  end
  
  def self.trash_pickup_threshold(calendar)
    (calendar.trash_pickup_threshold_seconds || DEFAULT_TRASH_PICKUP_THRESHOLD_SECONDS).seconds
  end
  
  def self.periodic_payment_threshold_after(calendar)
    (calendar.periodic_payment_after_threshold_seconds || DEFAULT_PERIODIC_PAYMENT_AFTER_THRESHOLD_SECONDS).seconds
  end
  
  def self.periodic_payment_threshold_before(calendar)
    (calendar.periodic_payment_before_threshold_seconds || DEFAULT_PERIODIC_PAYMENT_BEFORE_THRESHOLD_SECONDS).seconds
  end
  
  def self.event_threshold(calendar)
    (calendar.event_threshold_seconds || DEFAULT_EVENT_THRESHOLD_SECONDS).seconds.since
  end
  
  def self.stocks_vest_threshold(calendar)
    (calendar.stocks_vest_threshold_seconds || DEFAULT_STOCKS_VEST_THRESHOLD_SECONDS).seconds.since
  end
  
  def self.todo_threshold(calendar)
    (calendar.todo_threshold_seconds || DEFAULT_TODO_THRESHOLD_SECONDS).seconds.since
  end
  
  def self.pending_calendar_items(user, calendar)
    CalendarItemReminderPending
      .includes(:calendar, :calendar_item)
      .where(
        identity: user.primary_identity,
        calendar: calendar
      )
      .order("created_at DESC")
  end
  
  def self.recalculate_due(user)
    ActiveRecord::Base.transaction do
      CalendarItemReminder.ensure_pending(user)
    end
  end
  
  def self.destroy_due_items(user, model)
    begin
      if DueItem.new.respond_to?("myp_model_name")
        DueItem.destroy_all(identity: user.primary_identity, myp_model_name: model.name)
      end
    rescue ActiveRecord::DangerousAttributeError => e
      # Occurs in the full migration
      Rails.logger.info(e)
    end
  end
  
  def self.create_due_item(args)
    begin
      if DueItem.new.respond_to?("myp_model_name")
        DueItem.new(args).save!
      end
    rescue ActiveRecord::DangerousAttributeError => e
      # Occurs in the full migration
      Rails.logger.info(e)
    end
  end
  
  def self.create_due_item_check(args)
    begin
      if DueItem.new.respond_to?("myp_model_name")
        DueItem.new(args).check_and_save!
      end
    rescue ActiveRecord::DangerousAttributeError => e
      # Occurs in the full migration
      Rails.logger.info(e)
    end
  end

  # This will be called periodically by crontab
  def self.recalculate_all_users_due()
    Rails.logger.info("recalculate_all_users_due start")
    User.all.each do |user|
      begin
        User.current_user = user
        self.recalculate_due(user)
      ensure
        User.current_user = nil
      end
    end
    Rails.logger.info("recalculate_all_users_due end")
  end
  
  def self.check_snoozed_items(user, myp_model_name, updated_record, update_type)
    begin
      if ::SnoozedDueItem.new.respond_to?("myp_model_name")
        if !updated_record.nil? && !update_type.nil? && update_type == DueItem::UPDATE_TYPE_DELETE
          ::SnoozedDueItem.where(identity: user.primary_identity, myp_model_name: myp_model_name, model_id: updated_record.id).each do |snoozed_item|
            snoozed_item.destroy!
          end
        end
        
        ::SnoozedDueItem.where(identity: user.primary_identity, myp_model_name: myp_model_name).where("due_date <= ?", timenow).each do |snoozed_item|
          create_due_item(
            display: snoozed_item.display,
            link: snoozed_item.link,
            due_date: snoozed_item.due_date,
            original_due_date: snoozed_item.original_due_date,
            identity_id: snoozed_item.identity_id,
            calendar: snoozed_item.calendar,
            myp_model_name: snoozed_item.myp_model_name,
            model_id: snoozed_item.model_id
          )
        end
      end
    rescue ActiveRecord::DangerousAttributeError => e
      # Occurs in the full migration
      Rails.logger.info(e)
    end
  end
  
  def self.due_contacts(user, updated_record = nil, update_type = nil)
    destroy_due_items(user, Contact)
    
    user.primary_identity.calendars.each do |calendar|
      IdentityDriversLicense.where("identity_id = ? and expires is not null and expires < ?", user.primary_identity, drivers_license_expiration_threshold(calendar)).each do |drivers_license|
        contact = Contact.where(identity_id: user.primary_identity.id, contact_identity_id: drivers_license.identity.id).first
        diff = TimeDifference.between(timenow, drivers_license.expires)
        diff_in_general = diff.in_general
        create_due_item_check(
          display: I18n.t(
            "myplaceonline.identities.license_expiring",
            license: drivers_license.display,
            time: Myp.time_difference_in_general_human(diff_in_general)
          ),
          link: "/contacts/" + contact.id.to_s,
          due_date: drivers_license.expires,
          original_due_date: drivers_license.expires,
          identity: user.primary_identity,
          calendar: calendar,
          myp_model_name: Contact.name,
          model_id: contact.id
        )
      end

      Contact.where(identity: user.primary_identity).includes(:contact_identity).to_a.each do |x|
        if !x.contact_identity.nil? && !x.contact_identity.birthday.nil?
          next_birthday = x.contact_identity.next_birthday
          if next_birthday <= birthday_threshold(calendar)
            diff = TimeDifference.between(datenow, next_birthday)
            diff_in_general = diff.in_general
            create_due_item_check(
              display: I18n.t(
                "myplaceonline.contacts.upcoming_birthday",
                name: x.display,
                delta: Myp.time_difference_in_general_human(diff_in_general)
              ),
              link: "/contacts/" + x.id.to_s,
              due_date: next_birthday,
              original_due_date: next_birthday,
              identity: user.primary_identity,
              calendar: calendar,
              myp_model_name: Contact.name,
              model_id: x.id
            )
          end
        end
      end

      Contact.find_by_sql(%{
        SELECT contacts.*, max(conversations.conversation_date) as last_conversation_date
        FROM contacts
        LEFT OUTER JOIN conversations
          ON contacts.id = conversations.contact_id
        WHERE contacts.identity_id = #{user.primary_identity.id}
          AND contacts.contact_type IS NOT NULL
        GROUP BY contacts.id
        ORDER BY last_conversation_date ASC
      }).each do |contact|
        contact_threshold = contact_type_threshold(calendar)[contact.contact_type]
        if !contact_threshold.nil?
          if contact.last_conversation_date.nil?
            # No conversations at all
            create_due_item_check(
              display: I18n.t(
                "myplaceonline.contacts.no_conversations",
                name: contact.display,
                contact_type: Myp.get_select_name(contact.contact_type, Contact::CONTACT_TYPES)
              ),
              link: "/contacts/" + contact.id.to_s,
              due_date: datenow,
              original_due_date: datenow,
              identity: user.primary_identity,
              calendar: calendar,
              myp_model_name: Contact.name,
              model_id: contact.id,
              is_date_arbitrary: true
            )
          else
            if contact.last_conversation_date < contact_threshold
              create_due_item_check(
                display: I18n.t(
                  "myplaceonline.contacts.no_conversations_since",
                  name: contact.display,
                  contact_type: Myp.get_select_name(contact.contact_type, Contact::CONTACT_TYPES),
                  delta: Myp.time_difference_in_general_human(TimeDifference.between(datenow, contact.last_conversation_date).in_general)
                ),
                link: "/contacts/" + contact.id.to_s,
                due_date: contact.last_conversation_date,
                original_due_date: contact.last_conversation_date,
                identity: user.primary_identity,
                calendar: calendar,
                myp_model_name: Contact.name,
                model_id: contact.id
              )
            end
          end
        end
      end
    end

    check_snoozed_items(user, Contact.name, updated_record, update_type)
  end
  
  def self.due_exercises(user, updated_record = nil, update_type = nil)
    destroy_due_items(user, Exercise)
    
    user.primary_identity.calendars.each do |calendar|
      threshold = exercise_threshold(calendar)
      last_exercise = Exercise.where("identity_id = ? and exercise_start is not null", user.primary_identity).order('exercise_start DESC').limit(1).first
      if !last_exercise.nil? and last_exercise.exercise_start < threshold
        create_due_item_check(
          display: I18n.t(
            "myplaceonline.exercises.havent_exercised_for",
            delta: Myp.time_difference_in_general_human(TimeDifference.between(timenow, last_exercise.exercise_start).in_general)
          ),
          link: "/exercises/new",
          due_date: last_exercise.exercise_start,
          original_due_date: last_exercise.exercise_start,
          identity: user.primary_identity,
          calendar: calendar,
          myp_model_name: Exercise.name
        )
      end
    end

    check_snoozed_items(user, Exercise.name, updated_record, update_type)
  end
  
  def self.due_promotions(user, updated_record = nil, update_type = nil)
    destroy_due_items(user, Promotion)
    
    user.primary_identity.calendars.each do |calendar|
      Promotion.where("identity_id = ? and expires is not null and expires > ? and expires < ?", user.primary_identity, datenow, promotion_threshold(calendar)).each do |promotion|
        Rails.logger.debug{"Promotion due #{promotion.inspect}"}
        create_due_item_check(
          display: I18n.t(
            "myplaceonline.promotions.expires_soon",
            promotion_name: promotion.promotion_name,
            promotion_amount: Myp.number_to_currency(promotion.promotion_amount.nil? ? 0 : promotion.promotion_amount),
            expires_when: Myp.time_difference_in_general_human(TimeDifference.between(timenow, promotion.expires).in_general)
          ),
          link: "/promotions/" + promotion.id.to_s,
          due_date: promotion.expires,
          original_due_date: promotion.expires,
          identity: user.primary_identity,
          calendar: calendar,
          myp_model_name: Promotion.name,
          model_id: promotion.id
        )
      end
    end
    
    check_snoozed_items(user, Promotion.name, updated_record, update_type)
  end
  
  def self.due_gun_registrations(user, updated_record = nil, update_type = nil)
    destroy_due_items(user, GunRegistration)
    
    user.primary_identity.calendars.each do |calendar|
      GunRegistration.where("identity_id = ? and expires is not null and expires > ? and expires < ?", user.primary_identity, datenow, gun_registration_expiration_threshold(calendar)).each do |x|
        create_due_item_check(
          display: I18n.t(
            "myplaceonline.gun_registrations.expires_soon",
            gun_name: x.gun.display,
            delta: Myp.time_difference_in_general_human(TimeDifference.between(timenow, x.expires).in_general)
          ),
          link: "/guns/" + x.gun.id.to_s,
          due_date: x.expires,
          original_due_date: x.expires,
          identity: user.primary_identity,
          calendar: calendar,
          myp_model_name: GunRegistration.name,
          model_id: x.gun.id
        )
      end
    end

    check_snoozed_items(user, GunRegistration.name, updated_record, update_type)
  end
  
  def self.due_dental_cleanings(user, updated_record = nil, update_type = nil)
    #destroy_due_items(user, DentistVisit)
    
    user.primary_identity.calendars.each do |calendar|
      
#       last_dentist_visit = DentistVisit.where(
#         "identity_id = ? and cleaning = true",
#         user.primary_identity
#       ).order('visit_date DESC').limit(1).first
#       
#       if last_dentist_visit.nil?
#         if DentalInsurance.where("identity_id = ? and (defunct is null)", user.primary_identity).count > 0
# 
#           # If there are no dental visits for a cleaning and there is dental
#           # insurance, then create a persistent reminder to get a dental
#           # cleaning (if one doesn't already exist)
#           self.ensure_persistent_calendar_item(user.primary_identity, calendar, DentistVisit)
#         end
#       end
      
#       if !last_dentist_visit.nil? and last_dentist_visit.visit_date < dentist_visit_threshold(calendar)
#         create_due_item_check(
#           display: I18n.t(
#             "myplaceonline.dentist_visits.no_cleaning_for",
#             delta: Myp.time_difference_in_general_human(TimeDifference.between(timenow, last_dentist_visit.visit_date).in_general)
#           ),
#           link: "/dentist_visits/" + last_dentist_visit.id.to_s,
#           due_date: last_dentist_visit.visit_date,
#           original_due_date: last_dentist_visit.visit_date,
#           identity: user.primary_identity,
#           calendar: calendar,
#           myp_model_name: DentistVisit.name,
#           model_id: last_dentist_visit.id
#         )
#       elsif last_dentist_visit.nil?
#         # If there are no dentist visits at all but there is a dental insurance company, then notify
#         if DentalInsurance.where("identity_id = ? and (defunct is null)", user.primary_identity).count > 0
#           create_due_item_check(
#             display: I18n.t(
#               "myplaceonline.dentist_visits.no_cleanings"
#             ),
#             link: "/dentist_visits/new",
#             due_date: timenow,
#             original_due_date: timenow,
#             identity: user.primary_identity,
#             calendar: calendar,
#             myp_model_name: DentistVisit.name,
#             is_date_arbitrary: true
#           )
#         end
#       end
     end
     
#     check_snoozed_items(user, DentistVisit.name, updated_record, update_type)
  end
  
  def self.due_physicals(user, updated_record = nil, update_type = nil)
    destroy_due_items(user, DoctorVisit)
    
    user.primary_identity.calendars.each do |calendar|
      last_doctor_visit = DoctorVisit.where("identity_id = ? and physical = true", user.primary_identity).order('visit_date DESC').limit(1).first
      if !last_doctor_visit.nil? and last_doctor_visit.visit_date < doctor_visit_threshold(calendar)
        create_due_item_check(
          display: I18n.t(
            "myplaceonline.doctor_visits.no_physical_for",
            delta: Myp.time_difference_in_general_human(TimeDifference.between(timenow, last_doctor_visit.visit_date).in_general)
          ),
          link: "/doctor_visits/" + last_doctor_visit.id.to_s,
          due_date: last_doctor_visit.visit_date,
          original_due_date: last_doctor_visit.visit_date,
          identity: user.primary_identity,
          calendar: calendar,
          myp_model_name: DoctorVisit.name,
          model_id: last_doctor_visit.id
        )
      elsif last_doctor_visit.nil?
        # If there are no physicals at all but there is a health insurance company, then notify
        if HealthInsurance.where("identity_id = ? and (defunct is null)", user.primary_identity).count > 0
          create_due_item_check(
            display: I18n.t(
              "myplaceonline.doctor_visits.no_physicals"
            ),
            link: "/doctor_visits/new",
            due_date: timenow,
            original_due_date: timenow,
            identity: user.primary_identity,
            calendar: calendar,
            myp_model_name: DoctorVisit.name,
            is_date_arbitrary: true
          )
        end
      end
    end

    check_snoozed_items(user, DoctorVisit.name, updated_record, update_type)
  end
  
  def self.due_status(user, updated_record = nil, update_type = nil)
    destroy_due_items(user, Status)
    
    user.primary_identity.calendars.each do |calendar|
      last_status = Status.where("identity_id = ?", user.primary_identity).order('status_time DESC').limit(1).first
      if !last_status.nil? and last_status.status_time < status_threshold(calendar)
        create_due_item_check(
          display: I18n.t(
            "myplaceonline.statuses.no_recent_status",
            delta: Myp.time_difference_in_general_human(TimeDifference.between(timenow, last_status.status_time).in_general)
          ),
          link: "/statuses/new",
          due_date: last_status.status_time,
          original_due_date: last_status.status_time,
          identity: user.primary_identity,
          calendar: calendar,
          myp_model_name: Status.name,
          model_id: last_status.id
        )
      elsif last_status.nil?
        create_due_item_check(
          display: I18n.t(
            "myplaceonline.statuses.no_statuses"
          ),
          link: "/statuses/new",
          due_date: timenow,
          original_due_date: timenow,
          identity: user.primary_identity,
          calendar: calendar,
          myp_model_name: Status.name,
          is_date_arbitrary: true
        )
      end
    end

    check_snoozed_items(user, Status.name, updated_record, update_type)
  end
  
  def self.due_apartments(user, updated_record = nil, update_type = nil)
    destroy_due_items(user, Apartment)
    
    today = Date.today
    
    user.primary_identity.calendars.each do |calendar|
      Apartment.where("identity_id = ?", user.primary_identity).each do |apartment|
        apartment.apartment_trash_pickups.each do |trash_pickup|
          if trash_pickup.repeat
            next_pickup = trash_pickup.repeat.next_instance
            Rails.logger.debug{
              "Trash pickup: #{
                trash_pickup.inspect
              }, next: #{
                next_pickup
              }, threshold: #{
                trash_pickup_threshold(calendar)
              }, today: #{
                today
              }, diff: #{
                next_pickup - trash_pickup_threshold(calendar)
              }"
            }
            if next_pickup - trash_pickup_threshold(calendar) <= today
              create_due_item_check(
                display: I18n.t(
                  "myplaceonline.apartments.trash_pickup_reminder",
                  trash_type: Myp.get_select_name(trash_pickup.trash_type, ApartmentTrashPickup::TRASH_TYPES),
                  delta: Myp.time_difference_in_general_human(TimeDifference.between(Date.today, next_pickup).in_general)
                ),
                link: "/apartments/" + apartment.id.to_s,
                due_date: next_pickup,
                original_due_date: next_pickup,
                identity: user.primary_identity,
                calendar: calendar,
                myp_model_name: Apartment.name,
                model_id: apartment.id
              )
            end
          end
        end
      end
    end
    
    check_snoozed_items(user, Apartment.name, updated_record, update_type)
  end
  
  def self.due_periodic_payments(user, updated_record = nil, update_type = nil)
    destroy_due_items(user, PeriodicPayment)
    
    today = Date.today
    
    user.primary_identity.calendars.each do |calendar|
      PeriodicPayment.where("identity_id = ? and date_period is not null and ended is null", user.primary_identity).each do |x|
        if !x.suppress_reminder
          result = x.next_payment
          if !result.nil?
            if result == today
              create_due_item_check(
                display: I18n.t(
                  "myplaceonline.periodic_payments.reminder_today",
                  name: x.display
                ),
                link: "/periodic_payments/" + x.id.to_s,
                due_date: result,
                original_due_date: result,
                identity: user.primary_identity,
                calendar: calendar,
                myp_model_name: PeriodicPayment.name,
                model_id: x.id
              )
            elsif result - self.periodic_payment_threshold_before(calendar) <= today
              create_due_item_check(
                display: I18n.t(
                  "myplaceonline.periodic_payments.reminder_before",
                  name: x.display,
                  delta: Myp.time_difference_in_general_human(TimeDifference.between(result, today).in_general)
                ),
                link: "/periodic_payments/" + x.id.to_s,
                due_date: result,
                original_due_date: result,
                identity: user.primary_identity,
                calendar: calendar,
                myp_model_name: PeriodicPayment.name,
                model_id: x.id
              )
            else
              if x.date_period == 0
                result = result.advance(months: -1)
              elsif x.date_period == 1
                result = result.advance(years: -1)
              elsif x.date_period == 2
                result = result.advance(months: -6)
              end
              if today - self.periodic_payment_threshold_after(calendar) <= result
                create_due_item_check(
                  display: I18n.t(
                    "myplaceonline.periodic_payments.reminder_after",
                    name: x.display,
                    delta: Myp.time_difference_in_general_human(TimeDifference.between(result, today).in_general)
                  ),
                  link: "/periodic_payments/" + x.id.to_s,
                  due_date: result,
                  original_due_date: result,
                  identity: user.primary_identity,
                  calendar: calendar,
                  myp_model_name: PeriodicPayment.name,
                  model_id: x.id
                )
              end
            end
          end
        end
      end
    end

    check_snoozed_items(user, PeriodicPayment.name, updated_record, update_type)
  end
  
  def self.due_events(user, updated_record = nil, update_type = nil)
    destroy_due_items(user, Event)
    
    user.primary_identity.calendars.each do |calendar|
      Event.where("identity_id = ? and event_time is not null and event_time > ? and event_time < ?", user.primary_identity, datenow, event_threshold(calendar)).each do |x|
        create_due_item_check(
          display: I18n.t(
            "myplaceonline.events.upcoming",
            name: x.event_name,
            delta: Myp.time_difference_in_general_human(TimeDifference.between(timenow, x.event_time).in_general)
          ),
          link: "/events/" + x.id.to_s,
          due_date: x.event_time,
          original_due_date: x.event_time,
          identity: user.primary_identity,
          calendar: calendar,
          myp_model_name: Event.name,
          model_id: x.id
        )
      end
    end

    check_snoozed_items(user, Event.name, updated_record, update_type)
  end
  
  def self.due_stocks_vest(user, updated_record = nil, update_type = nil)
    destroy_due_items(user, Stock)
    
    user.primary_identity.calendars.each do |calendar|
      Stock.where("identity_id = ? and vest_date is not null and vest_date > ? and vest_date < ?", user.primary_identity, datenow, stocks_vest_threshold(calendar)).each do |x|
        create_due_item_check(
          display: I18n.t(
            "myplaceonline.stocks.upcoming",
            name: x.display,
            delta: Myp.time_difference_in_general_human(TimeDifference.between(timenow, x.vest_date).in_general)
          ),
          link: "/stocks/" + x.id.to_s,
          due_date: x.vest_date,
          original_due_date: x.vest_date,
          identity: user.primary_identity,
          calendar: calendar,
          myp_model_name: Stock.name,
          model_id: x.id
        )
      end
    end

    check_snoozed_items(user, Stock.name, updated_record, update_type)
  end
  
  def self.due_todos(user, updated_record = nil, update_type = nil)
    destroy_due_items(user, ToDo)
    
    if ToDo.new.respond_to?("due_time")
      user.primary_identity.calendars.each do |calendar|
        ToDo.where("identity_id = ? and due_time is not null and due_time > ? and due_time < ?", user.primary_identity, datenow, todo_threshold(calendar)).each do |x|
          create_due_item_check(
            display: I18n.t(
              "myplaceonline.to_dos.upcoming",
              name: x.display,
              delta: Myp.time_difference_in_general_human(TimeDifference.between(timenow, x.due_time).in_general)
            ),
            link: "/to_dos/" + x.id.to_s,
            due_date: x.due_time,
            original_due_date: x.due_time,
            identity: user.primary_identity,
            calendar: calendar,
            myp_model_name: ToDo.name,
            model_id: x.id
          )
        end
      end
    end

    check_snoozed_items(user, ToDo.name, updated_record, update_type)
  end
  
  # Reminder: When adding a new type of due item processing, consider
  # if the model should have after_save/after_destroy processing to 
  # recalculate due items
end
