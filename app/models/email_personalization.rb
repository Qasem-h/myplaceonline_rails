class EmailPersonalization < ActiveRecord::Base
  include MyplaceonlineActiveRecordIdentityConcern
  
  belongs_to :email
  
  attr_accessor :contact
end