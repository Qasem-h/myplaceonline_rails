class Connection < ActiveRecord::Base
  include MyplaceonlineActiveRecordIdentityConcern
  include AllowExistingConcern
  
  STATUS_PENDING = 1
  STATUS_CONNECTED = 2

  belongs_to :user
  accepts_nested_attributes_for :user, reject_if: :all_blank
  allow_existing :user

  validates :user, presence: true

  belongs_to :contact, dependent: :destroy
  accepts_nested_attributes_for :contact, reject_if: proc { |attributes| ContactsController.reject_if_blank(attributes) }
  allow_existing :contact

  def display
    user.display
  end
  
  validate do
    if self.connection_status.nil?
      self.connection_status = Connection::STATUS_PENDING
    end
    if self.connection_request_token.nil?
      self.connection_request_token = SecureRandom.hex(10)
    end
    if self.id.nil? && !user.nil? && user.id == User.current_user.id
      errors.add(:user, I18n.t("myplaceonline.connections.with_self"))
    end
  end

  after_commit :on_after_create, on: [:create]
  
  def on_after_create
    if MyplaceonlineExecutionContext.handle_updates?
      
      if self.connection_status == Connection::STATUS_PENDING
        body_markdown = I18n.t(
          "myplaceonline.connections.connection_request_body",
          name: User.current_user.display,
          link: Rails.application.routes.url_helpers.send("connection_accept_url", self.id, Rails.configuration.default_url_options) + "?token=" + self.connection_request_token
        )
        Myp.send_email(
          user.email,
          I18n.t("myplaceonline.connections.connection_request_subject", name: User.current_user.display),
          Myp.markdown_to_html(body_markdown).html_safe,
          nil,
          nil,
          body_markdown,
          User.current_user.email
        )
      end
      
    end
  end

  after_commit :on_after_destroy, on: :destroy
  
  def on_after_destroy
    Connection.destroy_all(user_id: self.identity.user.id, identity_id: self.user.primary_identity_id)
  end

  def self.create_contact(email)
    Contact.new(
      contact_identity: Identity.new(
        name: Identity.email_to_name(email),
        identity_emails: [ IdentityEmail.new(email: email) ]
      )
    )
  end
end
