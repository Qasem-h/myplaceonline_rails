require 'test_helper'

class PeriodicPaymentsControllerTest < ActionController::TestCase
  include MyplaceonlineControllerTest
  
  def test_attributes
    { periodic_payment_name: "test" }
  end
end
