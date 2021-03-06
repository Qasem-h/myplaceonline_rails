class WebsiteDomain < ApplicationRecord
  include MyplaceonlineActiveRecordIdentityConcern
  include AllowExistingConcern

  validates :domain_name, presence: true

  child_property(name: :website, required: true)

  child_property(name: :domain_host, model: Membership)
  
  child_properties(name: :website_domain_ssh_keys)

  child_properties(name: :website_domain_registrations)

  def display
    domain_name
  end
end
