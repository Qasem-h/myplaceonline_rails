class Wisdom < ActiveRecord::Base
  include MyplaceonlineActiveRecordIdentityConcern

  validates :name, presence: true
  
  def display
    name
  end
end
