class MoviesController < MyplaceonlineController
  protected
    def insecure
      true
    end

    def sorts
      ["lower(movies.name) ASC"]
    end

    def obj_params
      params.require(:movie).permit(
        :name,
        :url,
        :is_watched,
        :genre,
        :review,
        :lent_date,
        :borrowed_date,
        :is_owned,
        :is_discarded,
        :media_type,
        :number_of_media,
        recommender_attributes: ContactsController.param_names,
        lent_to_attributes: ContactsController.param_names,
        borrowed_from_attributes: ContactsController.param_names,
      )
    end
end
