class EmailsController < MyplaceonlineController
  
  def self.param_names
    [
      :id,
      :subject,
      :body,
      :copy_self,
      :email_category,
      :use_bcc,
      :draft,
      :personalize,
      email_contacts_attributes: [
        :id,
        :_destroy,
        contact_attributes: ContactsController.param_names
      ],
      email_groups_attributes: [
        :id,
        :_destroy,
        group_attributes: GroupsController.param_names
      ],
      email_personalizations_attributes: EmailsController.email_personalizations_attributes 
    ]
  end
  
  def self.email_personalizations_attributes
    [
      :do_send,
      :target,
      :additional_text
    ]
  end
  
  def after_create
    if !@obj.draft
      if !@obj.personalize
        final_send
      end
    end
    super
  end
  
  def redirect_to_obj
    if !@obj.draft
      if !@obj.personalize
        final_redirect
      else
        Myp.clear_points_flash(session)
        redirect_to(emails_personalize_path(@obj))
      end
    else
      super
    end
  end

  def index
    @draft = params[:draft]
    if !@draft.blank?
      @draft = @draft.to_bool
    end
    super
  end

  def personalize
    set_obj
    
    if !request.patch?
      @obj.all_targets.each do |email, contact|
        @obj.email_personalizations.build({target: email, do_send: true, contact: contact})
      end
    else
      @obj.update_attributes(params.require(:email).permit(
        email_personalizations_attributes: EmailsController.email_personalizations_attributes 
      ))
      if @obj.save
        final_send
        final_redirect
      end
    end
  end

  protected
    def sorts
      ["emails.updated_at DESC"]
    end

    def obj_params
      params.require(:email).permit(EmailsController.param_names)
    end

    def all_additional_sql(strict)
      if @draft && !strict
        "and draft = true"
      else
        nil
      end
    end
    
    def send_immediately
      @obj.email_groups.count == 0 && @obj.email_contacts.count < 5
    end
    
    def final_send
      if send_immediately
        AsyncEmailJob.perform_now(@obj)
      else
        AsyncEmailJob.perform_later(@obj)
      end
    end
    
    def final_redirect
      redirect_to obj_path,
            :flash => { :notice =>
                        I18n.t(send_immediately ? "myplaceonline.emails.send_sucess_sync" : "myplaceonline.emails.send_sucess_async")
                      }
    end
end
