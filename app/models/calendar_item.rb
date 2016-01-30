class CalendarItem < ActiveRecord::Base
  include MyplaceonlineActiveRecordIdentityConcern
  
  belongs_to :calendar

  has_many :calendar_item_reminders, :dependent => :destroy
  
  def display
    if @cached_display.nil?
      model = Object.const_get(model_class)
      @cached_display = model.display_calendar_item(self)
    end
    @cached_display
  end
  
  def link
    if model_id.nil?
      "/" + model_class.pluralize.underscore + "/new"
    else
    end
  end

  def short_date
    if Date.today.year > calendar_item_time.year
      Myp.display_date_short_year(calendar_item_time, User.current_user)
    else
      Myp.display_date_short(calendar_item_time, User.current_user)
    end
  end

  def self.has_persistent_calendar_item(identity, calendar, model)
    CalendarItem.where(
      "identity_id = ? and calendar_id = ? and model_class = ?",
      identity,
      calendar,
      model.name
    ).count > 0
  end
  
  def self.create_persistent_calendar_item(identity, calendar, model)
    ActiveRecord::Base.transaction do
      calendar_item = CalendarItem.new(
        identity: identity,
        calendar: calendar,
        persistent: true,
        model_class: model.name
      )
      
      calendar_item.save!
      
      calendar_item_reminder = CalendarItemReminder.new(
        identity: identity,
        calendar_item: calendar_item
      )
      
      calendar_item_reminder.save!
      
      # Persistent items always have a reminder pending
      
      CalendarItemReminderPending.new(
        calendar_item_reminder: calendar_item_reminder,
        calendar: calendar,
        calendar_item: calendar_item,
        identity: identity
      ).save!

      calendar_item
    end
  end
  
  def self.ensure_persistent_calendar_item(identity, calendar, model)
    if !self.has_persistent_calendar_item(identity, calendar, model)
      self.create_persistent_calendar_item(identity, calendar, model)
    end
  end
  
  def self.destroy_calendar_items(identity, model)
    CalendarItem.where(
      identity: identity,
      model_class: model.name
    ).each do |calendar_item|
      calendar_item.destroy!
    end
  end
  
  def self.create_calendar_item(identity, calendar, model, calendar_item_time, reminder_threshold_amount, reminder_threshold_type)
    ActiveRecord::Base.transaction do
      calendar_item = CalendarItem.new(
        identity: identity,
        calendar: calendar,
        model_class: model.name,
        calendar_item_time: calendar_item_time
      )
      
      calendar_item.save!
      
      calendar_item_reminder = CalendarItemReminder.new(
        identity: identity,
        calendar_item: calendar_item,
        threshold_amount: reminder_threshold_amount,
        threshold_type: reminder_threshold_type
      )
      
      calendar_item_reminder.save!
      
      # Non-persistent items will only have a reminder pending if the reminder
      # threshold has been crossed - leave it up to the crontab to figure
      # that out
      
      calendar_item
    end
  end
end
