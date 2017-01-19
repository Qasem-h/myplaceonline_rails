class HealthInsurancesController < MyplaceonlineController
  def self.param_names
    [
      :id,
      :_destroy,
      :insurance_name,
      :notes,
      :account_number,
      :group_number,
      password_attributes: PasswordsController.param_names,
      insurance_company_attributes: CompaniesController.param_names,
      periodic_payment_attributes: PeriodicPaymentsController.param_names,
      group_company_attributes: CompaniesController.param_names,
      doctor_attributes: DoctorsController.param_names,
      health_insurance_files_attributes: FilesController.multi_param_names
    ]
  end

  def may_upload
    true
  end

  protected
    def sorts
      ["lower(health_insurances.insurance_name) ASC"]
    end

    def obj_params
      params.require(:health_insurance).permit(
        HealthInsurancesController.param_names
      )
    end

    def sensitive
      true
    end
end
