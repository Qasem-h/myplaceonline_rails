class DoctorVisitsController < MyplaceonlineController
  protected
    def sorts
      ["doctor_visits.visit_date DESC"]
    end

    def obj_params
      params.require(:doctor_visit).permit(
        :visit_date,
        :paid,
        :physical,
        :notes,
        doctor_attributes: DoctorsController.param_names,
        health_insurance_attributes: HealthInsurancesController.param_names
      )
    end
end
