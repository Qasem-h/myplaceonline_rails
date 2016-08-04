class ProjectIssuesController < MyplaceonlineController
  def path_name
    "project_project_issue"
  end

  def form_path
    "project_issues/form"
  end

  def data_split_icon
    "arrow-u"
  end
  
  def split_link(obj)
    ActionController::Base.helpers.link_to(
      I18n.t("myplaceonline.project_issues.move_top"),
      project_project_issues_movetop_path(obj.project, obj)
    )
  end
  
  def movetop
    set_obj
    original_position = @obj.position
    ActiveRecord::Base.transaction do
      i = 2
      @parent.project_issues.each do |issue|
        if issue.id == @obj.id
          @obj.position = 1
          @obj.save!
        else
          issue.position = i
          i = i + 1
          issue.save!
        end
      end
    end
    redirect_to project_project_issues_path(@parent),
      :flash => { :notice => I18n.t("myplaceonline.project_issues.moved_top") }
  end
  
  protected
    def insecure
      true
    end

    def sorts
      ["project_issues.position ASC"]
    end

    def obj_params
      params.require(:project_issue).permit(
        :issue_name, :notes
      )
    end
    
    def has_category
      false
    end
    
    def nested
      true
    end
    
    def additional_items?
      false
    end

    def parent_model
      Project
    end
end
