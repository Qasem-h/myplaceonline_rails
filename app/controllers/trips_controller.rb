class TripsController < MyplaceonlineController
  def model
    Trip
  end

  def display_obj(obj)
    obj.display
  end

  def may_upload
    true
  end
  
  protected
    def sorts
      ["trips.started DESC"]
    end

    def obj_params
      params.require(:trip).permit(
        :started,
        :ended,
        :notes,
        :work,
        select_or_create_permit(:trip, :location_attributes, LocationsController.param_names),
        trip_pictures_attributes: [
          :id,
          :_destroy,
          identity_file_attributes: [
            :id,
            :file,
            :notes
          ]
        ]
      )
    end
    
    def presave
      @obj.trip_pictures.each do |pic|
        if pic.identity_file.folder.nil?
          pic.identity_file.folder = IdentityFileFolder.find_or_create([I18n.t("myplaceonline.category.trips"), @obj.location.display_general_region])
        end
      end
    end
end