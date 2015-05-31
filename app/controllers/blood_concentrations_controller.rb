class BloodConcentrationsController < MyplaceonlineController
  def model
    BloodConcentration
  end

  def display_obj(obj)
    obj.display
  end

  protected
    def sorts
      ["lower(blood_concentrations.concentration_name) ASC"]
    end

    def obj_params
      params.require(:blood_concentration).permit(BloodConcentration.params)
    end
    
    def has_category
      false
    end
end