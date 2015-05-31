class SkinTreatmentsController < MyplaceonlineController
  def model
    SkinTreatment
  end

  def display_obj(obj)
    obj.display
  end

  protected
    def sorts
      ["skin_treatments.treatment_time DESC"]
    end

    def obj_params
      params.require(:skin_treatment).permit(
        :treatment_time,
        :treatment_activity,
        :treatment_location
      )
    end
end