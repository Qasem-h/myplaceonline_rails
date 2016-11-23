class FeedItem < ActiveRecord::Base
  include MyplaceonlineActiveRecordIdentityConcern
  include ModelHelpersConcern

  belongs_to :feed

  boolean_time_transfer :is_read, :read

  validates :feed_title, presence: true
  validates :feed_link, presence: true
  
  def display
    feed_title
  end
  
  def display_icon
    Myp.categories["feeds"].icon
  end
  
  def ideal_path
    "/feeds/#{feed.id}/feed_items/#{self.id}"
  end

  after_commit :on_after_update, on: [:update]
  
  def on_after_update
    self.feed.reset_counts
  end
end
