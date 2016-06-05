class AdminSendEmailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Rails.logger.info{"Started AdminSendEmailJob"}
    
    admin_email = args[0]

    Rails.logger.debug{"Email: #{admin_email.inspect}; #{admin_email.email.inspect}"}
    
    send_only_to = nil
    if !admin_email.send_only_to.blank?
      send_only_to = admin_email.send_only_to.split(",").map{|e| [e, true]}.to_h
    end
    
    exclude_emails = nil
    if !admin_email.exclude_emails.blank?
      exclude_emails = admin_email.exclude_emails.split(",").map{|e| [e, true]}.to_h
    end

    User.all.each do |user|
      if send_only_to.nil? || send_only_to[user.email]
        if exclude_emails.nil? || !exclude_emails[user.email]
          admin_email.email.process_single_target(user.email)
        end
      end
    end
    
    Rails.logger.info{"Ended AdminSendEmailJob"}
  end
end