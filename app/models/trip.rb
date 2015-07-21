class Trip < ActiveRecord::Base
  belongs_to :owner, class_name: Identity

  validates :location, presence: true
  validates :started, presence: true

  belongs_to :location
  accepts_nested_attributes_for :location, reject_if: proc { |attributes| LocationsController.reject_if_blank(attributes) }
  
  # http://stackoverflow.com/a/12064875/4135310
  def location_attributes=(attributes)
    if !attributes['id'].blank?
      attributes.keep_if {|innerkey, innervalue| innerkey == "id" }
      self.location = Location.find(attributes['id'])
    end
    super
  end
  
  has_many :trip_pictures, :dependent => :destroy
  accepts_nested_attributes_for :trip_pictures, allow_destroy: true, reject_if: :all_blank
  
  def display
    result = Myp.display_date_short_year(started, User.current_user)
    if !ended.nil?
      result += " - " + Myp.display_date_short_year(ended, User.current_user)
    end
    result += " (" + location.display_simple + ")"
    if work
      result += " (" + I18n.t("myplaceonline.trips.work") + ")"
    end
    result
  end

  before_create :do_before_save
  before_update :do_before_save

  def do_before_save
    Myp.set_common_model_properties(self)
  end
end
