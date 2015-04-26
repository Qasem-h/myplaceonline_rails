class Meal < ActiveRecord::Base
  belongs_to :identity
  validates :meal_time, presence: true
  
  belongs_to :location, :autosave => true
  accepts_nested_attributes_for :location, reject_if: proc { |attributes| LocationsController.reject_if_blank(attributes) }

  before_create :do_before_save
  before_update :do_before_save

  def do_before_save
    Myp.set_common_model_properties(self)
  end

  has_many :meal_foods, :dependent => :destroy
  accepts_nested_attributes_for :meal_foods, allow_destroy: true, reject_if: :all_blank

  has_many :meal_drinks, :dependent => :destroy
  accepts_nested_attributes_for :meal_drinks, allow_destroy: true, reject_if: :all_blank
end
