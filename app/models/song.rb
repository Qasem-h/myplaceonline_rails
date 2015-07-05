class Song < ActiveRecord::Base
  belongs_to :owner, class: Identity
  validates :song_name, presence: true
  
  def display
    song_name
  end
  
  before_create :do_before_save
  before_update :do_before_save

  def do_before_save
    Myp.set_common_model_properties(self)
  end
end
