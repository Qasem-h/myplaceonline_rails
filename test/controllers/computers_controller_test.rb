require 'test_helper'

class ComputersControllerTest < ActionController::TestCase
  include MyplaceonlineControllerTest
  
  def test_attributes
    { computer_model: "test" }
  end
end
