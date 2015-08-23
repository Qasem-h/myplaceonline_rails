class MedicineUsage < MyplaceonlineIdentityRecord
  include AllowExistingConcern

  validates :usage_time, presence: true
  
  has_many :medicine_usage_medicines, :dependent => :destroy
  accepts_nested_attributes_for :medicine_usage_medicines, allow_destroy: true, reject_if: :all_blank
  allow_existing_children :medicine_usage_medicines, [{:name => :medicine}]
  
  def display
    Myp.display_datetime_short(usage_time, User.current_user)
  end
end
