class EventsController < MyplaceonlineController
  def may_upload
    true
  end

  def use_bubble?
    true
  end
  
  def bubble_text(obj)
    Myp.display_date_short_year(obj.event_time, User.current_user)
  end

  def shared
    @obj = model.find_by(id: params[:id])
    authorize! :show, @obj
  end
  
  def share
    set_obj
    
    redirect_to(
      permissions_share_token_path(
        subject_class: @obj.class.name,
        subject_id: @obj.id,
        child_selections: @obj.event_pictures.map{|x| x.id}.join(",")
      )
    )
  end

  def rsvp
    @obj = model.find_by(id: params[:id])
    authorize! :show, @obj
    
    if params[:type] == Event::RSVP_YES.to_s
      flash = "myplaceonline.events.rsvp_success_reminder"
      flash_type = "myplaceonline.events.rsvp_yes"
    elsif params[:type] == Event::RSVP_MAYBE.to_s
      flash = "myplaceonline.events.rsvp_success_reminder"
      flash_type = "myplaceonline.events.rsvp_maybe"
    else
      flash = "myplaceonline.events.rsvp_success"
      flash_type = "myplaceonline.events.rsvp_no"
    end
    
    redirect_to(
      event_shared_path(token: params[:token], email: params[:email]),
      :flash => { :notice => I18n.t(flash, type: I18n.t(flash_type)) }
    )
  end
  
  def show_share
    false
  end

  protected
    def sorts
      ["events.event_time DESC"]
    end
    
    def obj_params
      params.require(:event).permit(
        :event_name,
        :event_time,
        :event_end_time,
        :notes,
        location_attributes: LocationsController.param_names,
        repeat_attributes: Repeat.params,
        event_pictures_attributes: FilesController.multi_param_names + [:position],
        event_contacts_attributes: [
          :id,
          :_destroy,
          contact_attributes: ContactsController.param_names
        ]
      )
    end

    def insecure
      true
    end
end
