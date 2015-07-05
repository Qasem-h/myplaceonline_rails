class HypothesisExperiment < ActiveRecord::Base
  belongs_to :hypothesis
  belongs_to :owner, class: Identity

  validates :name, presence: true

  before_create :do_before_save
  before_update :do_before_save

  def do_before_save
    Myp.set_common_model_properties(self)
  end
end
