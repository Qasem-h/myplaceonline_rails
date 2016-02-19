class Membership < ActiveRecord::Base
  include MyplaceonlineActiveRecordIdentityConcern
  include AllowExistingConcern

  validates :name, presence: true
  
  belongs_to :periodic_payment
  accepts_nested_attributes_for :periodic_payment, reject_if: proc { |attributes| PeriodicPaymentsController.reject_if_blank(attributes) }
  allow_existing :periodic_payment
  
  def display
    name
  end

  def self.calendar_item_display(calendar_item)
    obj = calendar_item.find_model_object
    now = User.current_user.time_now
    if obj.end_date > now
      message_type = "myplaceonline.general.expires"
    else
      message_type = "myplaceonline.general.expired"
    end
    I18n.t(
      message_type,
      display: obj.display,
      delta: Myp.time_delta(obj.end_date)
    )
  end
  
  after_commit :on_after_save, on: [:create, :update]
  
  def on_after_save
    ActiveRecord::Base.transaction do
      CalendarItem.destroy_calendar_items(User.current_user.primary_identity, self.class, model_id: id)
      if !end_date.nil?
        User.current_user.primary_identity.calendars.each do |calendar|
          CalendarItem.create_calendar_item(
            User.current_user.primary_identity,
            calendar,
            self.class,
            end_date,
            (calendar.general_threshold_seconds || Calendar::DEFAULT_REMINDER_AMOUNT),
            Calendar::DEFAULT_REMINDER_TYPE,
            model_id: id
          )
        end
      end
    end
  end
  
  after_commit :on_after_destroy, on: :destroy
  
  def on_after_destroy
    CalendarItem.destroy_calendar_items(User.current_user.primary_identity, self.class, model_id: self.id)
  end
end
