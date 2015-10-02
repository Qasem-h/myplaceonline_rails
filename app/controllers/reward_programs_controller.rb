class RewardProgramsController < MyplaceonlineController
  def index
    @program_type = params[:program_type]
    if !@program_type.blank?
      @program_type = @program_type.to_i
    end
    super
  end

  protected
    def sorts
      ["lower(reward_programs.reward_program_name) ASC"]
    end

    def all_additional_sql
      if !@program_type.blank?
        "and program_type = " + @program_type
      else
        nil
      end
    end
    
    def obj_params
      params.require(:reward_program).permit(
        :reward_program_name,
        :started,
        :ended,
        :reward_program_number,
        :reward_program_status,
        :notes,
        :program_type,
        Myp.select_or_create_permit(params[:reward_program], :password_attributes, PasswordsController.param_names),
      )
    end
end
