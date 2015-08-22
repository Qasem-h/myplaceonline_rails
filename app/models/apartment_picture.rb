class ApartmentPicture < MyplaceonlineActiveRecord
  include AllowExistingConcern

  belongs_to :apartment

  belongs_to :identity_file
  accepts_nested_attributes_for :identity_file, reject_if: :all_blank
  allow_existing :identity_file
end
