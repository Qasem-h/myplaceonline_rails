class ToDo < ActiveRecord::Base
  belongs_to :owner, class: Identity
  validates :short_description, presence: true
  
  def display
    short_description
  end
  
  before_create :do_before_save
  before_update :do_before_save

  def do_before_save
    Myp.set_common_model_properties(self)
  end
end
