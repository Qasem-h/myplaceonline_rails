class Trip < ActiveRecord::Base
  include MyplaceonlineActiveRecordIdentityConcern
  include AllowExistingConcern
  include ActionView::Helpers
  include ActionDispatch::Routing
  include Rails.application.routes.url_helpers

  validates :location, presence: true
  validates :started, presence: true

  belongs_to :location
  accepts_nested_attributes_for :location, reject_if: proc { |attributes| LocationsController.reject_if_blank(attributes) }
  allow_existing :location
  
  belongs_to :hotel
  accepts_nested_attributes_for :hotel, reject_if: proc { |attributes| HotelsController.reject_if_blank(attributes) }
  allow_existing :hotel

  has_many :trip_pictures, :dependent => :destroy
  accepts_nested_attributes_for :trip_pictures, allow_destroy: true, reject_if: :all_blank
  allow_existing_children :trip_pictures, [{:name => :identity_file}]
  
  has_many :trip_stories, :dependent => :destroy
  accepts_nested_attributes_for :trip_stories, allow_destroy: true, reject_if: :all_blank
  allow_existing_children :trip_stories, [{:name => :story}]
  
  belongs_to :identity_file

  before_validation :update_pic_folders
  
  def update_pic_folders
    folders = Array.new
    folders.push(I18n.t("myplaceonline.category.trips"))
    if !self.location.region_name.blank?
      folders.push(self.location.region_name)
    end
    if !self.location.sub_region1_name.blank?
      folders.push(self.location.sub_region1_name)
    end
    if !self.location.sub_region2.blank?
      folders.push(self.location.sub_region2)
    end
    if folders.length == 1
      if !self.location.display_general_region.blank?
        folders.push(self.location.display_general_region)
      end
    end
    put_files_in_folder(trip_pictures, folders)
  end
  
  def display
    if ended.nil?
      result = Myp.display_date_short_year(started, User.current_user)
    else
      result = Myp.display_date_short(started, User.current_user)
    end
    if !ended.nil?
      result += " - " + Myp.display_date_short_year(ended, User.current_user)
    end
    result += " (" + location.display_simple + ")"
    if work
      result += " (" + I18n.t("myplaceonline.trips.work") + ")"
    end
    result
  end
  
  def self.has_shared_page?
    true
  end
  
  def self.share_async?(permission_share)
    true
  end
  
  def self.execute_share(permission_share)
    
    obj = Myp.find_existing_object!(permission_share.subject_class, permission_share.subject_id)

    count = 0
    
    include_pics = permission_share.child_selections_list
    source_list = obj.trip_pictures.to_a.dup.keep_if{|x| !include_pics.index(x.id).nil? }
    
    Myp.mktmpdir do |dir|
      
      files = Array.new
      identity_files = Array.new
      
      source_list.each do |trip_picture|
        if !trip_picture.identity_file.nil?
          count = count + 1
          data = trip_picture.identity_file.file.file_contents
          name = trip_picture.identity_file.file_file_name
          
          f = File.join(dir, name)

          itemarray = Array.new
          itemarray.push(name)
          itemarray.push(f)
          
          files.push(itemarray)
          
          identity_files.push(trip_picture.identity_file)
          
          IO.binwrite(f, data)
        end
      end
      
      Rails.logger.info{"Trip execute_share. count: #{count}, obj: #{obj.inspect}"}

      if count > 0
        Myp.tmpfile("trip" + obj.id.to_s + "_", ".zip") do |tfile|
          Zip::File.open(tfile.path, Zip::File::CREATE) do |zipfile|
            files.each do |filename|
              zipfile.add(filename[0], filename[1])
            end
          end
          
          zipdata = IO.binread(tfile.path)
          
          begin
            User.current_user = obj.identity.user
            
            ActiveRecord::Base.transaction do
              iff = IdentityFileFolder.find_or_create([I18n.t("myplaceonline.category.trips")])
              identity_file = IdentityFile.build({ folder: iff.id })
              identity_file.file_file_name = Pathname.new(tfile).basename
              identity_file.file_file_size = zipdata.length
              identity_file.file_content_type = "application/zip"
              if zipdata.length > IdentityFile::SIZE_THRESHOLD_FILESYSTEM
                dest = Pathname.new(Rails.configuration.filetmpdir).join(File.basename(tfile.path))
                FileUtils.cp(tfile.path, dest)
                FileUtils.chmod(0755, dest)
                identity_file.filesystem_path = dest
              else
                identity_file.file = File.open(tfile.path)
              end
              identity_file.folder = iff
              identity_file.identity = obj.identity
              identity_file.save!
              
              obj.identity_file = identity_file
              obj.save!
              
              psc = PermissionShareChild.new
              psc.identity = obj.identity
              psc.share = permission_share.share
              psc.subject_class = IdentityFile.name
              psc.subject_id = identity_file.id
              psc.permission_share = permission_share
              psc.save!

              identity_files.each do |identity_file|
                psc = PermissionShareChild.new
                psc.identity = obj.identity
                psc.share = permission_share.share
                psc.subject_class = IdentityFile.name
                psc.subject_id = identity_file.id
                psc.permission_share = permission_share
                psc.save!
              end
              
              permission_share.send_email(obj)
            end
          ensure
            User.current_user = nil
          end
        end
      end
    end
  end
  
  def add_email_html(target_email, target_contact, permission_share)
    result = ""
    trip_pictures.each do |trip_picture|
      if !permission_share.permission_share_children.index{|psc| psc.subject_id == trip_picture.identity_file.id}.nil?
        result += "\n<hr />\n<p>#{ActionController::Base.helpers.image_tag(file_thumbnail_url(trip_picture.identity_file, token: permission_share.share.token))}</p>"
        if !trip_picture.identity_file.notes.blank?
          result += "\n<p>#{Myp.markdown_to_html(trip_picture.identity_file.notes)}</p>"
        end
      end
    end
    result
  end

  protected
  def default_url_options
    Rails.configuration.default_url_options
  end
end
