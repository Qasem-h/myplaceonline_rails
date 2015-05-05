class CreditCardsController < MyplaceonlineController
  skip_authorization_check :only => MyplaceonlineController::DEFAULT_SKIP_AUTHORIZATION_CHECK + [:listcashback]

  def listcashback
    @cashbacks = CreditCardCashback.where(identity_id: current_user.primary_identity.id).sort{ |x, y| y.cashback.cashback_percentage <=> x.cashback.cashback_percentage }.keep_if{|c| c.expiration_includes_today?}
  end

  def model
    CreditCard
  end

  def display_obj(obj)
    obj.display
  end
  
  def cashback_for(cb)
    if cb.cashback.applies_to.blank?
      ""
    else
      I18n.t("myplaceonline.general.for") + " " + cb.cashback.applies_to + " "
    end
  end

  protected
    def sorts
      ["lower(credit_cards.name) ASC"]
    end

    def obj_params
      params.require(:credit_card).permit(
        :name,
        :number,
        :expires,
        :security_code,
        :pin,
        :notes,
        :encrypt,
        :is_defunct,
        :card_type,
        select_or_create_permit(:credit_card, :password_attributes, PasswordsController.param_names),
        select_or_create_permit(:credit_card, :address_attributes, LocationsController.param_names),
        credit_card_cashbacks_attributes: [
          :id,
          :_destroy,
          cashback_attributes: Cashback.params
        ]
      )
    end
    
    def sensitive
      true
    end

    def create_presave
      if !@obj.name.blank? && !@obj.number.blank? && @obj.number.length >= 4
        @obj.name += " (" + @obj.number.last(4) + ")"
      end
      if !@obj.password.nil?
        @obj.password.identity = current_user.primary_identity
      end
      if !@obj.address.nil?
        @obj.address.identity = current_user.primary_identity
      end
      @obj.number_finalize
      @obj.security_code_finalize
      @obj.pin_finalize
      @obj.expires_finalize
      update_defunct
    end

    def update_presave
      @obj.number_finalize
      @obj.security_code_finalize
      @obj.pin_finalize
      @obj.expires_finalize
      update_defunct
    end
    
    def update_defunct
      if @obj.is_defunct == "1"
        @obj.defunct = Time.now
      else
        @obj.defunct = nil
      end
    end

    def before_edit
      @obj.encrypt = @obj.number_encrypted?
      @obj.is_defunct = !@obj.defunct.nil?
    end
end
