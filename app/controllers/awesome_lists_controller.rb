class AwesomeListsController < MyplaceonlineController
  def search_index_name
    Location.table_name
  end

  def search_parent_category
    category_name.singularize
  end

  protected
    def sorts
      ["awesome_lists.updated_at DESC"]
    end

    def obj_params
      params.require(:awesome_list).permit(
        :notes,
        location_attributes: LocationsController.param_names,
        awesome_list_items_attributes: [:id, :_destroy, :item_name]
      )
    end
end
