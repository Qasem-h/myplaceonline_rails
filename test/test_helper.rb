ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include Devise::TestHelpers
  
  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = users(:user)
    @user.confirm!
    sign_in @user
  end
end

module MyplaceonlineControllerTest
  extend ActiveSupport::Testing::Declarative
  
  def model
    raise NotImplementedError
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:objs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create" do
    assert_difference(model.name + '.count') do
      post :create, model.name.downcase => { identity_id: @user.primary_identity_id, name: "test" }
    end

    assert_redirected_to send(model.name.downcase + "_path", assigns(:obj))
  end

  test "should show" do
    get :show, id: send(model.table_name, model.name.downcase)
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: send(model.table_name, model.name.downcase)
    assert_response :success
  end

  test "should update" do
    patch :update, id: send(model.table_name, model.name.downcase), model.name.downcase => { name: "test" }
    assert_redirected_to send(model.name.downcase + "_path", assigns(:obj))
  end

  test "should destroy" do
    assert_difference(model.name + '.count', -1) do
      delete :destroy, id: send(model.table_name, model.name.downcase)
    end

    assert_redirected_to send(model.table_name + "_path")
  end
end
