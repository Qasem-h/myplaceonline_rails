class ApartmentsController < MyplaceonlineController
  
  def model
    Apartment
  end

  def display_obj(obj)
    obj.location.name
  end

  protected
    def sorts
      ["apartments.updated_at DESC"]
    end
    
    def new_build
      @obj.location = Location.new
      @obj.landlord = Contact.new
      @obj.landlord.ref = Identity.new
    end

    def obj_params
      params.require(:apartment).permit(
        location_attributes: LocationsController.param_names.push(:id),
        landlord_attributes: ContactsController.param_names.push(:id),
        apartment_leases_attributes: [:id, :start_date, :end_date, :monthly_rent, :moveout_fee, :deposit, :_destroy]
      )
    end
    
    def create_presave
      @obj.location.identity = current_user.primary_identity
      @obj.landlord.identity = current_user.primary_identity
    end
    
    def presave
      set_from_existing(:location_selection, Location, :location)
      set_from_existing(:landlord_selection, Contact, :landlord)
    end
    
    def update_presave
      @obj.apartment_leases.each {
        |lease|
        if !lease.apartment.nil?
          authorize! :manage, lease.apartment
        end
      }
    end
end
