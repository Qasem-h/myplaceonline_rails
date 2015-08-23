class CreditScore < MyplaceonlineIdentityRecord
  validates :score_date, presence: true
  validates :score, presence: true
  
  def display
    Myp.display_date(score_date, User.current_user) + " (" + score.to_s + ")"
  end
  
  def self.build(params = nil)
    result = super(params)
    result.score_date = Date.today
    result
  end
end
