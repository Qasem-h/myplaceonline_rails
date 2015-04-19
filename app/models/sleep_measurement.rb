class SleepMeasurement < ActiveRecord::Base
  belongs_to :identity
  
  validates :sleep_start_time, presence: true
  
  def display
    if !sleep_end_time.nil?
      Myp.display_datetime_short(sleep_start_time, User.current_user) + " - " + Myp.display_datetime_short(sleep_end_time, User.current_user)
    else
      Myp.display_datetime_short(sleep_start_time, User.current_user) + " - " + I18n.t("myplaceonline.general.unknown")
    end
  end
  
  def to_s_difference
    if !sleep_end_time.nil?
      Myp.time_difference_in_general_human_detailed(TimeDifference.between(sleep_start_time, sleep_end_time).in_general)
    else
      nil
    end
  end

  before_create :do_before_save
  before_update :do_before_save
  
  def do_before_save
    Myp.set_common_model_properties(self)
  end
end
