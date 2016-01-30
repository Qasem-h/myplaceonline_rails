class Promotion < ActiveRecord::Base
  include MyplaceonlineActiveRecordIdentityConcern

  DEFAULT_PROMOTION_THRESHOLD_SECONDS = 15.days

  validates :promotion_name, presence: true
  
  def display
    result = promotion_name
    if !promotion_amount.nil?
      result += " (" + Myp.number_to_currency(promotion_amount) + ")"
    end
    if !expires.nil?
      result += " (" + I18n.t("myplaceonline.promotions.expires") + " " + Myp.display_date_short_year(expires, User.current_user) + ")"
    end
    result
  end

  def self.calendar_item_display(calendar_item)
    promotion = calendar_item.find_model_object
    I18n.t(
      "myplaceonline.promotions.expires_soon",
      promotion_name: promotion.promotion_name,
      promotion_amount: Myp.number_to_currency(promotion.promotion_amount.nil? ? 0 : promotion.promotion_amount),
      expires_when: Myp.time_difference_in_general_human(TimeDifference.between(User.current_user.time_now, promotion.expires).in_general)
    )
  end
  
  after_commit :on_after_save, on: [:create, :update]
  
  def on_after_save
    if !expires.nil?
      ActiveRecord::Base.transaction do
        CalendarItem.destroy_calendar_items(User.current_user.primary_identity, self.class, model_id: id)
        User.current_user.primary_identity.calendars.each do |calendar|
          CalendarItem.create_calendar_item(
            User.current_user.primary_identity,
            calendar,
            self.class,
            expires,
            (calendar.promotion_threshold_seconds || DEFAULT_PROMOTION_THRESHOLD_SECONDS),
            Calendar::DEFAULT_REMINDER_TYPE,
            model_id: id
          )
        end
      end
    end
  end
  
  after_commit :on_after_destroy, on: :destroy
  
  def on_after_destroy
    CalendarItem.destroy_calendar_items(User.current_user.primary_identity, self.class, self.id)
  end
end
