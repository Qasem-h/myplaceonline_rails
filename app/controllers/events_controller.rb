class EventsController < MyplaceonlineController
  protected
    def sorts
      ["lower(events.event_name) ASC"]
    end
    
    def obj_params
      params.require(:event).permit(
        :event_name,
        :event_time,
        :notes,
        repeat_attributes: Repeat.params
      )
    end
end
