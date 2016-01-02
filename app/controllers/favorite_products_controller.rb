class FavoriteProductsController < MyplaceonlineController
  protected
    def insecure
      true
    end

    def sorts
      ["lower(favorite_products.product_name) ASC"]
    end

    def obj_params
      params.require(:favorite_product).permit(
        :product_name,
        :notes,
        favorite_product_links_attributes: [:id, :_destroy, :link]
      )
    end
end
