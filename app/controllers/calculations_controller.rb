class CalculationsController < MyplaceonlineController
  def after_create_or_update
    respond_to do |format|
      format.html {
        flash[:notice] = I18n.t("myplaceonline.calculations.result") + " = " + @obj.evaluate
        render :edit
      }
      format.js { super.after_create_or_update }
    end
  end

  protected
    def sorts
      ["lower(calculations.name) ASC"]
    end

    def obj_params
      params.require(:calculation).permit(
        :name,
        :original_calculation_form_id,
        calculation_form_attributes: CalculationFormsController.param_names
      )
    end
end
