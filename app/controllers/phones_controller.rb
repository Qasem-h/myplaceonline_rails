class PhonesController < MyplaceonlineController
  protected
    def sorts
      ["lower(phones.model_name) ASC"]
    end

    def obj_params
      params.require(:phone).permit(
        :model_name,
        :phone_number,
        :purchased,
        :price,
        :operating_system,
        :operating_system_version,
        :max_resolution_width,
        :max_resolution_height,
        :ram,
        :num_cpus,
        :num_cores_per_cpu,
        :hyperthreaded,
        :max_cpu_speed,
        :cdma,
        :gsm,
        :front_camera_megapixels,
        :back_camera_megapixels,
        :notes,
        Myp.select_or_create_permit(params[:phone], :manufacturer_attributes, CompaniesController.param_names(params[:phone][:manufacturer_attributes])),
        Myp.select_or_create_permit(params[:phone], :password_attributes, PasswordsController.param_names)
      )
    end
end
