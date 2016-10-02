class BankAccountsController < MyplaceonlineController
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
        :is_archived,
        password_attributes: PasswordsController.param_names,
        company_attributes: CompaniesController.param_names,
        home_address_attributes: LocationsController.param_names
      )
    end

    def sensitive
      true
    end
end
