class FeedItemsController < MyplaceonlineController
  def path_name
    "feed_feed_item"
  end

  def form_path
    "feed_items/form"
  end

  def nested
    true
  end

  def mark_read
    set_obj
    @obj.is_read = true
    @obj.save!
    render json: { result: true }
  end

  protected
    def insecure
      true
    end

    def sorts
      ["feed_items.publication_date DESC"]
    end

    def obj_params
      params.require(:feed_item).permit(
        :feed_title,
        :feed_link,
        :content,
        :publication_date,
        :guid,
        :is_read
      )
    end
    
    def has_category
      false
    end
    
    def additional_items?
      false
    end

    def parent_model
      Feed
    end
end