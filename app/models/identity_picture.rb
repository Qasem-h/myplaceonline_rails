class IdentityPicture < MyplaceonlineActiveRecord
  include AllowExistingConcern

  belongs_to :identity, class_name: Identity

  belongs_to :identity_file
  accepts_nested_attributes_for :identity_file, reject_if: :all_blank
  allow_existing :identity_file
end
