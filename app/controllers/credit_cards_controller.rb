class CreditCardsController < MyplaceonlineController
  def model
    CreditCard
  end

  def display_obj(obj)
    obj.name
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
        select_or_create_permit(:credit_card, :password_attributes, PasswordsController.param_names),
        select_or_create_permit(:credit_card, :address_attributes, LocationsController.param_names)
      )
    end
    
    def create_presave
      if !@obj.password.nil?
        @obj.password.identity = current_user.primary_identity
      end
      if !@obj.address.nil?
        @obj.address.identity = current_user.primary_identity
      end
    end
end