class MedicineUsagesController < MyplaceonlineController
  protected
    def insecure
      true
    end

    def sorts
      ["medicine_usages.usage_time DESC"]
    end

    def obj_params
      params.require(:medicine_usage).permit(
        :usage_time,
        :usage_notes,
        medicine_usage_medicines_attributes: [
          :id,
          :_destroy,
          medicine_attributes: Medicine.params
        ]
      )
    end
end
