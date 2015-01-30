class Subscription < ActiveRecord::Base
  belongs_to :identity
  validates :name, presence: true
end