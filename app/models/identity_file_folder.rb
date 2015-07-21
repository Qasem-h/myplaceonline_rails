class IdentityFileFolder < ActiveRecord::Base
  belongs_to :owner, class_name: Identity
  
  belongs_to :parent_folder, class_name: IdentityFileFolder
  accepts_nested_attributes_for :parent_folder

  # http://stackoverflow.com/a/12064875/4135310
  def parent_folder_attributes=(attributes)
    if !attributes['id'].blank?
      self.parent_folder = IdentityFileFolder.find(attributes['id'])
    end
    super
  end

  validates :folder_name, presence: true

  def display
    folder_name
  end
  
  has_many :identity_files, :dependent => :destroy, :foreign_key => "folder_id"
  
  def subfolders
    IdentityFileFolder.where(
      owner_id: User.current_user.primary_identity.id,
      parent_folder: self.id
    ).order(FileFoldersController.sorts)
  end

  before_create :do_before_save
  before_update :do_before_save

  def do_before_save
    Myp.set_common_model_properties(self)
  end
  
  def self.find_or_create(names, parent = nil)
    names = names.reverse
    while names.length > 0
      name = names.pop
      if parent.nil?
        folders = IdentityFileFolder.where(
          owner_id: User.current_user.primary_identity.id,
          folder_name: name
        )
        if folders.length == 0
          parent = IdentityFileFolder.new(folder_name: name, owner_id: User.current_user.primary_identity.id)
          parent.save!
        elsif folders.length == 1
          parent = folders[0]
        else
          raise "TODO"
        end
      else
        folders = IdentityFileFolder.where(
          owner_id: User.current_user.primary_identity.id,
          folder_name: name,
          parent_folder_id: parent.id
        )
        if folders.length == 0
          parent = IdentityFileFolder.new(folder_name: name, owner_id: User.current_user.primary_identity.id, parent_folder_id: parent.id)
          parent.save!
        elsif folders.length == 1
          parent = folders[0]
        else
          raise "TODO"
        end
      end
    end
    parent
  end
end
