class RewardProgram < ActiveRecord::Base
  
  REWARD_PROGRAM_TYPES = [
    ["myplaceonline.reward_programs.type_plane", 0],
    ["myplaceonline.reward_programs.type_hotel", 1],
    ["myplaceonline.reward_programs.type_car", 2]
  ]
  
  belongs_to :owner, class_name: Identity

  belongs_to :password
  accepts_nested_attributes_for :password, reject_if: proc { |attributes| PasswordsController.reject_if_blank(attributes) }
  
  # http://stackoverflow.com/a/12064875/4135310
  def password_attributes=(attributes)
    if !attributes['id'].blank?
      attributes.keep_if {|innerkey, innervalue| innerkey == "id" }
      self.password = Password.find(attributes['id'])
    end
    super
  end
  
  validates :reward_program_name, presence: true

  def display(show_default_cashback = true)
    result = reward_program_name
    result
  end
  
  before_create :do_before_save
  before_update :do_before_save

  def do_before_save
    Myp.set_common_model_properties(self)
  end
end
