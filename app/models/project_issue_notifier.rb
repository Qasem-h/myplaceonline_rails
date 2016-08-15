class ProjectIssueNotifier < ActiveRecord::Base
  include MyplaceonlineActiveRecordIdentityConcern
  include AllowExistingConcern

  belongs_to :project_issue

  validates :contact, presence: true

  belongs_to :contact
  accepts_nested_attributes_for :contact, reject_if: proc { |attributes| ContactsController.reject_if_blank(attributes) }
  allow_existing :contact
end