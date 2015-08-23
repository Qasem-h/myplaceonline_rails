class DiaryEntriesController < MyplaceonlineController
  protected
    def sorts
      ["diary_entries.diary_time DESC"]
    end

    def obj_params
      params.require(:diary_entry).permit(
        :diary_time,
        :entry
      )
    end
end
