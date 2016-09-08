class TripPicture < ActiveRecord::Base
  include MyplaceonlineActiveRecordIdentityConcern
  include AllowExistingConcern

  belongs_to :trip
  
  belongs_to :identity_file
  accepts_nested_attributes_for :identity_file, reject_if: :all_blank
  allow_existing :identity_file
  
  def display
    identity_file.display
  end

  before_validation :update_pic_folders
  
  def update_pic_folders
    put_file_in_folder(self, trip.picture_folders)
  end
end
