class Feed < MyplaceonlineActiveRecord
  validates :name, presence: true
  validates :url, presence: true
  
  def display
    name
  end
end
