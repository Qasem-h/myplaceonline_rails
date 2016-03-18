class Email < ActiveRecord::Base
  include MyplaceonlineActiveRecordIdentityConcern
  include ActionView::Helpers
  include ActionDispatch::Routing
  include Rails.application.routes.url_helpers

  validates :subject, presence: true
  validates :body, presence: true
  validates :email_category, presence: true

  has_many :email_contacts, :dependent => :destroy
  accepts_nested_attributes_for :email_contacts, allow_destroy: true, reject_if: :all_blank

  has_many :email_groups, :dependent => :destroy
  accepts_nested_attributes_for :email_groups, allow_destroy: true, reject_if: :all_blank

  has_many :email_personalizations, :dependent => :destroy
  accepts_nested_attributes_for :email_personalizations, allow_destroy: true, reject_if: :all_blank

  def display
    subject
  end

  validate do
    if email_contacts.length == 0 && email_groups.length == 0
      errors.add(:email_contacts, I18n.t("myplaceonline.permissions.requires_contacts"))
    end
  end
  
  def all_targets
    targets = {}

    email_contacts.each do |email_contact|
      email_contact.contact.contact_identity.emails.each do |identity_email|
        targets[identity_email] = email_contact.contact
      end
    end

    email_groups.each do |email_group|
      process_group(targets, email_group.group)
    end
    
    targets
  end
  
  def send_email(body2_html = nil, body2_plain = nil, target_obj = nil, permission_share = nil)
    
    content = "<p>" + Myp.markdown_to_html(body) + "</p>"
    if !body2_html.nil?
      content += "\n\n" + body2_html
    end
    content_plain = body
    if !body2_plain.nil?
      content_plain += "\n\n" + body2_plain
    end
    
    targets = all_targets

    targets.delete_if{
      |target_email, target_contact|

      !EmailUnsubscription.where(
        "email = ? and (category is null or category = ?) and (identity_id is null or identity_id = ?)",
        target_email,
        email_category,
        identity.id
      ).first.nil?
    }
    
    user_display = identity.display
    
    targets.each do |target, contact|
      to_hash = {}
      cc_hash = {}
      bcc_hash = {}
      
      if use_bcc
        bcc_hash[target] = true
      else
        to_hash[target] = true
      end

      if copy_self
        bcc_hash[identity.user.email] = true
      end
      
      Rails.logger.info{"Email check: #{target}"}

      et = EmailToken.new
      et.token = SecureRandom.hex(10)
      et.email = target
      et.identity = identity
      et.save!
      
      unsubscribe_all_link = unsubscribe_url(email: target, token: et.token)
      unsubscribe_category_link = unsubscribe_url(email: target, category: email_category, token: et.token)
      
      user_display_short = identity.display_short
      user_email = identity.user.email
      
      personalization = EmailPersonalization.where(target: target, identity: identity, email: self).first
      
      if personalization.nil? || personalization.do_send
        
        final_content = content + "\n\n<p>&nbsp;</p>\n"

        if !personalization.nil? && !personalization.additional_text.blank?
          final_content += "<p>" + Myp.markdown_to_html(personalization.additional_text) + "</p>"
        end
        
        if !target_obj.nil? && target_obj.respond_to?("add_email_html")
          final_content += target_obj.add_email_html(target, contact, permission_share)
        end
        
        final_content += "<hr />\n"
        final_content += "<p>#{ActionController::Base.helpers.link_to(I18n.t("myplaceonline.unsubscribe.link_unsubscribe_category", user: user_display, category: email_category), unsubscribe_category_link)}</p>\n"
        final_content += "<p>#{ActionController::Base.helpers.link_to(I18n.t("myplaceonline.unsubscribe.link_unsubscribe_all", user: user_display), unsubscribe_all_link)}</p>"
        final_content += "\n<p>\n--\n<br />\n"
        if user_display_short != user_email
          final_content += "#{user_display_short}<br />\n"
        end
        final_content += "#{user_email}"
        final_content += "\n<br />\n" + identity.phones.map{|p| "<a href=\"tel:#{p}\">#{p}</a>"}.join(" | ")
        final_content += "</p>"
        
        final_content_plain = content_plain + "\n\n"

        if !personalization.nil? && !personalization.additional_text.blank?
          final_content_plain += personalization.additional_text + "\n"
        end
        
        final_content_plain += "\n===============\n\n"
        final_content_plain += "#{I18n.t("myplaceonline.unsubscribe.link_unsubscribe_category", user: user_display, category: email_category)}: #{unsubscribe_category_link}\n"
        final_content_plain += "#{I18n.t("myplaceonline.unsubscribe.link_unsubscribe_all", user: user_display)}: #{unsubscribe_all_link}"
        final_content_plain += "\n\n--\n"
        if user_display_short != user_email
          final_content_plain += "#{user_display_short}\n"
        end
        final_content_plain += "#{user_email}\n"
        final_content_plain += identity.phones.join(" | ")
        
        final_content = final_content.gsub("%{name}", contact.contact_identity.display_short)
        final_content_plain = final_content_plain.gsub("%{name}", contact.contact_identity.display_short)
        
        Rails.logger.info{"Sending email"}

        Myp.send_email(
          to_hash.keys,
          subject,
          final_content.html_safe,
          cc_hash.keys,
          bcc_hash.keys,
          final_content_plain,
          identity.user.email
        )
        
        # If we sent an email, add a conversation
        Conversation.new(
          contact: contact,
          identity: identity,
          conversation: "[#{subject}](/emails/#{id})",
          conversation_date: User.current_user.date_now
        ).save!
        
        sleep(1.0)
      end
    end
  end
  
  def process_group(to_hash, group)
    group.group_contacts.each do |group_contact|
      group_contact.contact.contact_identity.emails.each do |identity_email|
        to_hash[identity_email] = group_contact.contact
      end
    end
    group.group_references.each do |group_reference|
      process_group(to_hash, group_reference.group)
    end
  end

  def self.build(params = nil)
    result = self.dobuild(params)
    #result.use_bcc = true
    #result.copy_self = true
    
    if !params.nil? && !params["email_source_class"].blank?
      obj = Myp.find_existing_object(params["email_source_class"], params["email_source_id"].to_i)
      result.subject = obj.display
      result.body = obj.send(params["email_source_body_field"])
    end
    
    result
  end

  protected
  def default_url_options
    Rails.configuration.default_url_options
  end
end