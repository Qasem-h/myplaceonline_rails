class CafesController < MyplaceonlineController
  def search_index_name
    Location.table_name
  end

  def search_parent_category
    category_name.singularize
  end

  protected
    def insecure
      true
    end

    def sorts
      ["cafes.updated_at DESC"]
    end

    def obj_params
      params.require(:cafe).permit(
        :notes,
        :rating,
        location_attributes: LocationsController.param_names
      )
    end
end
