class Passport < ActiveRecord::Base
  include MyplaceonlineActiveRecordIdentityConcern
  include AllowExistingConcern

  validates :region, presence: true
  validates :passport_number, presence: true
  
  def display
    region + " (" + passport_number + ")"
  end
  
  has_many :passport_pictures, :dependent => :destroy
  accepts_nested_attributes_for :passport_pictures, allow_destroy: true, reject_if: :all_blank
  allow_existing_children :passport_pictures, [{:name => :identity_file}]

  before_validation :update_pic_folders
  
  def update_pic_folders
    put_files_in_folder(passport_pictures, [I18n.t("myplaceonline.category.passports"), display])
  end

end
