class BankAccountsController < MyplaceonlineController
  def index
    @defunct = params[:defunct]
    if !@defunct.blank?
      @defunct = @defunct.to_bool
    end
    super
  end

  protected
    def sorts
      ["lower(bank_accounts.name) ASC"]
    end

    def obj_params
      params.require(:bank_account).permit(
        :name,
        :account_number,
        :routing_number,
        :pin,
        :encrypt,
        :is_defunct,
        Myp.select_or_create_permit(params[:bank_account], :password_attributes, PasswordsController.param_names),
        Myp.select_or_create_permit(params[:bank_account], :company_attributes, CompaniesController.param_names(params[:bank_account][:company_attributes])),
        Myp.select_or_create_permit(params[:bank_account], :home_address_attributes, LocationsController.param_names)
      )
    end

    def sensitive
      true
    end

    def all
      if @defunct.blank? || !@defunct
        model.where("owner_id = ? and defunct is null", current_user.primary_identity)
      else
        model.where(
          owner_id: current_user.primary_identity.id
        )
      end
    end
end
