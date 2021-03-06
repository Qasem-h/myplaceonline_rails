class QuotesController < MyplaceonlineController
  protected
    def insecure
      true
    end

    def sorts
      ["lower(quotes.quote_text) ASC"]
    end

    def obj_params
      params.require(:quote).permit(Quote.params)
    end
end
