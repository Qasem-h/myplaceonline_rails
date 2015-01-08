class Contact < ActiveRecord::Base
  belongs_to :ref, class_name: Identity, :dependent => :destroy
  belongs_to :identity
  accepts_nested_attributes_for :ref
  
  validates_presence_of :ref
  validate :custom_validation
  
  def custom_validation
    if contact_identity.name.blank?
      errors.add(:name, "not specified")
    end
  end

  def name
    contact_identity.name
  end
  
  def birthday
    contact_identity.birthday
  end
  
  def notes
    contact_identity.notes
  end
  
  def contact_identity
    ref
  end

  def as_json(options={})
    super.as_json(options).merge({
      :contact_identity => ref.as_json
    })
  end

  def display
    name
  end
end
