class Loan < ActiveRecord::Base
  belongs_to :identity
  
  validates :lender, presence: true

  before_create :do_before_save
  before_update :do_before_save

  def do_before_save
    Myp.set_common_model_properties(self)
  end
  
  def self.params
    [
      :id,
      :lender,
      :amount,
      :start,
      :paid_off,
      :monthly_payment,
    ]
  end
end
