class MembershipsController < MyplaceonlineController
  def self.param_names
    [
      :id,
      :_destroy,
      :name,
      :start_date,
      :end_date,
      :notes,
      :membership_identifier,
      periodic_payment_attributes: PeriodicPaymentsController.param_names,
      membership_files_attributes: FilesController.multi_param_names,
      password_attributes: PasswordsController.param_names
    ]
  end

  def may_upload
    true
  end

  protected
    def sorts
      ["lower(memberships.name) ASC"]
    end

    def obj_params
      params.require(:membership).permit(
        MembershipsController.param_names
      )
    end
end
