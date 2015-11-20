class MyplaceonlineDueDisplaysController < MyplaceonlineController
  def showmyplet
    @due = DueItem.all_due(current_user)
    if @due.length == 0
      @nocontent = true
    end
  end
  
  def self.permit_params()
    [
      :exercise_threshold,
      :contact_best_friend_threshold
    ]
  end
  
  protected
    def sorts
      ["myplaceonline_due_displays.updated_at DESC"]
    end

    def obj_params
      params.require(:myplaceonline_due_display).permit(permit_params)
    end

    def has_category
      false
    end
end
