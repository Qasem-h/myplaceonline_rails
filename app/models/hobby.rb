class Hobby < MyplaceonlineIdentityRecord
  validates :hobby_name, presence: true
  
  def display
    hobby_name
  end
end
