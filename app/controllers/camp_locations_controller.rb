class CampLocationsController < MyplaceonlineController
  protected
    def sorts
      ["camp_locations.updated_at DESC"]
    end

    def obj_params
      params.require(:camp_location).permit(
        :notes,
        :rating,
        :vehicle_parking,
        :free,
        :sewage,
        :fresh_water,
        :electricity,
        :internet,
        :trash,
        :shower,
        :bathroom,
        :noise_level,
        :overnight_allowed,
        :boondocking,
        :cell_phone_reception,
        :cell_phone_data,
        location_attributes: LocationsController.param_names,
        membership_attributes: MembershipsController.param_names
      )
    end
end
