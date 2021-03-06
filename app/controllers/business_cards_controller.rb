class BusinessCardsController < MyplaceonlineController
  def may_upload
    true
  end

  def self.param_names
    [
      :id,
      :_destroy,
      contact_attributes: ContactsController.param_names,
      business_card_files_attributes: FilesController.multi_param_names
    ]
  end

  protected
    def sorts
      ["business_cards.updated_at DESC"]
    end

    def obj_params
      params.require(:business_card).permit(
        BusinessCardsController.param_names
      )
    end
end
