class BloodTest < ApplicationRecord
  include MyplaceonlineActiveRecordIdentityConcern
  include AllowExistingConcern
  include AllowExistingConcern

  validates :test_time, presence: true
  
  def display
    Myp.appendstrwrap(Myp.display_datetime_short_year(test_time, User.current_user), self.preceding_changes)
  end
  
  child_properties(name: :blood_test_results)

  child_property(name: :location)

  child_property(name: :doctor)

  child_files
end
