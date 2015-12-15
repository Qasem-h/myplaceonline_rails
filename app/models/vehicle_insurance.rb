class VehicleInsurance < ActiveRecord::Base
  include MyplaceonlineActiveRecordIdentityConcern
  include AllowExistingConcern

  belongs_to :vehicle

  validates :insurance_name, presence: true

  belongs_to :company
  accepts_nested_attributes_for :company, allow_destroy: true, reject_if: :all_blank
  allow_existing :company

  belongs_to :periodic_payment
  accepts_nested_attributes_for :periodic_payment, allow_destroy: true, reject_if: :all_blank
  allow_existing :periodic_payment
end
