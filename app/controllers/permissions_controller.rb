class PermissionsController < MyplaceonlineController
  skip_authorization_check :only => MyplaceonlineController::DEFAULT_SKIP_AUTHORIZATION_CHECK + [:share, :share_token]

  def self.param_names
    [
      :id,
      :_destroy,
      :subject_class,
      :subject_id,
      :actionbit1,
      :actionbit2,
      :actionbit4,
      :actionbit8,
      :actionbit16,
      user_attributes: [:id]
    ]
  end

  def share
    @permission = Permission.new(
      params.require(:permission).permit(
        PermissionsController.param_names
      )
    )
    @subject = I18n.t("myplaceonline.permissions.default_subject", {
      subject_class: @permission.category_display.singularize
    })
    @body = I18n.t("myplaceonline.permissions.default_body", {
      subject_class: @permission.category_display.singularize,
      contact: User.current_user.display,
      link: @permission.url
    })
    @copy_self = true
    if request.post?
      save_result = @permission.save
      if save_result
        
        content = "<p>" + ERB::Util.html_escape_once(@body) + "</p>\n\n"
        content += "<p>" + ActionController::Base.helpers.link_to(@permission.url, @permission.url) + "</p>"
        
        cc = nil
        if @copy_self
          cc = User.current_user.email
        end
        to = [@permission.user.email]
        Myp.send_email(to, @subject, content.html_safe, cc)

        return redirect_to @permission.path,
          :flash => { :notice =>
                      I18n.t("myplaceonline.permissions.shared_sucess")
                    }
      end
    end
  end

  def share_token
    @share = Myp.new_model(PermissionShare)
    @share.email = true
    @share.copy_self = true
    @share.subject_class = params[:subject_class]
    @share.subject_id = params[:subject_id]

    @check_obj = Object.const_get(@share.subject_class).find_by(id: @share.subject_id)
    authorize! :show, @check_obj

    if request.post?
      @share = PermissionShare.new(
        params.require(:permission_share).permit(
          :subject,
          :body,
          :email,
          :copy_self,
          :subject_class,
          :subject_id,
          permission_share_contacts_attributes: [
            :_destroy,
            contact_attributes: [
              :id
            ]
          ]
        )
      )
      @share.identity = User.current_user.primary_identity
      
      public_share = Share.new
      public_share.identity = @share.identity
      public_share.token = SecureRandom.hex(10)
      public_share.save!
      
      @share.share = public_share
      
      save_result = @share.save
      if save_result

        if @share.async?
          ShareJob.perform_later(@share)

          redirect_to "/",
            :flash => { :notice =>
                        I18n.t("myplaceonline.permissions.shared_sucess_async")
                      }
        else
          @share.send_email

          redirect_to "/",
            :flash => { :notice =>
                        I18n.t("myplaceonline.permissions.shared_sucess")
                      }
        end
      end
    end
  end
  
  protected
    def sorts
      ["permissions.updated_at DESC"]
    end

    def obj_params
      params.require(:permission).permit(
        PermissionsController.param_names
      )
    end
end
