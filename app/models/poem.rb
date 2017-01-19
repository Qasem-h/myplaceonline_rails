class Poem < ApplicationRecord
  include MyplaceonlineActiveRecordIdentityConcern

  validates :poem_name, presence: true
  
  def display
    poem_name
  end
end
