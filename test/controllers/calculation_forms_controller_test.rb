require 'test_helper'

class CalculationFormsControllerTest < ActionController::TestCase
  include MyplaceonlineControllerTest
  
  def model
    CalculationForm
  end
  
  def test_attributes
    { name: "test" }
  end
end