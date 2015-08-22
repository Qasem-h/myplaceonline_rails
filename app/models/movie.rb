class Movie < MyplaceonlineActiveRecord
  validates :name, presence: true
  attr_accessor :is_watched
  
  def display
    name
  end
end
