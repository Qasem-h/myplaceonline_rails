class EventContact < ActiveRecord::Base
  include MyplaceonlineActiveRecordIdentityConcern
  include AllowExistingConcern

  belongs_to :event

  belongs_to :contact
  accepts_nested_attributes_for :contact, reject_if: :all_blank
  allow_existing :contact
end
