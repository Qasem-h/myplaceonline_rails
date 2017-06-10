class WebsiteDomainSshKey < ApplicationRecord
  include MyplaceonlineActiveRecordIdentityConcern
  include AllowExistingConcern

  belongs_to :website_domain
  
  def display
    self.username
  end

  child_property(name: :ssh_key)
end
