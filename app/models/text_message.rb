class TextMessage < ApplicationRecord
  include MyplaceonlineActiveRecordIdentityConcern

  validates :body, presence: true
  validates :message_category, presence: true

  child_properties(name: :text_message_contacts)

  child_properties(name: :text_message_groups)

  def display
    body
  end

  validate do
    if !draft && text_message_contacts.length == 0 && text_message_groups.length == 0
      errors.add(:text_message_contacts, I18n.t("myplaceonline.permissions.requires_contacts"))
    end
  end
  
  def all_targets
    targets = {}

    text_message_contacts.each do |text_message_contact|
      Rails.logger.debug{"TextMessage.all_targets contact: #{text_message_contact.inspect}"}
      text_message_contact.contact.contact_identity.identity_phones.each do |identity_phone|
        Rails.logger.debug{"TextMessage.all_targets found phone: #{identity_phone.inspect}"}
        if identity_phone.accepts_sms?
          Rails.logger.debug{"TextMessage.all_targets accepts SMS"}
          targets[identity_phone.number] = text_message_contact.contact
        end
      end
    end

    text_message_groups.each do |text_message_group|
      Rails.logger.debug{"TextMessage.all_targets process group: #{text_message_group.inspect}"}
      process_group(targets, text_message_group.group)
    end
    
    targets
  end
  
  def send_sms()
    targets = all_targets

    targets.each do |target, contact|
      process_single_target(target, nil, contact)
    end
    if copy_self
      User.current_user.current_identity_identity_phones.each do |identity_phone|
        if identity_phone.accepts_sms?
          process_single_target(identity_phone.number)
        end
      end
    end
  end
  
  def process_single_target(target, content = nil, contact = nil)

    if content.nil?
      content = "#{identity.display_short} #{I18n.t("myplaceonline.emails.subject_shared")}: "
      content += body
    end
    
    target = TextMessage.normalize(phone_number: target)
    
    Rails.logger.debug{"SMS process_single_target target: #{target}, content: #{content}"}

    if TextMessageUnsubscription.where(
        "phone_number = ? and (category is null or category = ?) and (identity_id is null or identity_id = ?)",
        target,
        message_category,
        identity.id
      ).first.nil?
      
      Rails.logger.info{"Sending SMS to #{target}"}

      Myp.send_sms(to: target, body: content)
      
      last_text_message = LastTextMessage.where(phone_number: target).take
      if last_text_message.nil?
        last_text_message = LastTextMessage.new(
          phone_number: target,
          category: self.message_category,
          identity_id: User.current_user.current_identity_id
        )
      end
      last_text_message.save!

      if !contact.nil?
        # If we sent an email, add a conversation
        Conversation.new(
          contact: contact,
          identity: identity,
          conversation: "[#{content}](/text_messages/#{id})",
          conversation_date: User.current_user.date_now
        ).save!
      end
      
      sleep(1.0)
    end
  end
  
  def process_group(to_hash, group)
    group.group_contacts.each do |group_contact|
      group_contact.contact.contact_identity.identity_phones.each do |identity_phone|
        if identity_phone.accepts_sms?
          to_hash[identity_phone.number] = group_contact.contact
        end
      end
    end
    group.group_references.each do |group_reference|
      process_group(to_hash, group_reference.group)
    end
  end

  def send_immediately
    text_message_groups.count == 0 && text_message_contacts.count < 5
  end
  
  def process
    if send_immediately
      AsyncTextMessageJob.perform_now(self)
    else
      AsyncTextMessageJob.perform_later(self)
    end
  end

  def self.skip_check_attributes
    ["draft", "copy_self"]
  end
  
  def self.normalize(phone_number:)
    if phone_number.nil?
      phone_number = ""
    end
    phone_number = phone_number.gsub(/[^\d]+/, "")
    if phone_number.length == 10
      phone_number = "1" + phone_number
    end
    if !phone_number.start_with?("+")
      phone_number = "+" + phone_number
    end
    phone_number
  end
end
