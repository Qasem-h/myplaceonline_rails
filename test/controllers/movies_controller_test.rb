require 'test_helper'

class MoviesControllerTest < ActionController::TestCase
  include MyplaceonlineControllerTest
  
  def model
    Movie
  end
  
  def test_attributes
    { name: "test" }
  end
end
