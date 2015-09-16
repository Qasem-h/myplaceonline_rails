class WebsitesController < MyplaceonlineController
  protected
    def insecure
      true
    end

    def sorts
      ["lower(websites.title) ASC"]
    end

    def obj_params
      params.require(:website).permit(:title, :url)
    end
end
