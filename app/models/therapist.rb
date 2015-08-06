class Therapist < ActiveRecord::Base

  belongs_to :owner, class_name: Identity

  validates :name, presence: true

  def display
    name
  end
  
  has_many :therapist_conversations, :dependent => :destroy
  accepts_nested_attributes_for :therapist_conversations, allow_destroy: true, reject_if: :all_blank
  
  def all_conversations
    TherapistConversation.where(therapist_id: id).order(["therapist_conversations.conversation_date DESC"])
  end
  
  before_create :do_before_save
  before_update :do_before_save

  def do_before_save
    Myp.set_common_model_properties(self)
  end
end
