class DietaryRequirementsCollectionsController < MyplaceonlineController
  def may_upload
    true
  end

  protected
    def insecure
      true
    end

    def sorts
      ["lower(dietary_requirements_collections.dietary_requirements_collection_name) ASC"]
    end

    def obj_params
      params.require(:dietary_requirements_collection).permit(
        :dietary_requirements_collection_name,
        :notes,
        dietary_requirements_collections_attributes: FilesController.multi_param_names,
      )
    end
end
