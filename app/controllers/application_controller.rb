class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # TODO broken with JQueryMobile on login/logout
  #protect_from_forgery with: :exception

  # By default, all pages require authentication unless the controller has
  #   skip_before_filter :authenticate_user!
  before_action :authenticate_user!
  
  around_filter :set_current_user
  
  around_filter :set_current_session
  
  check_authorization
  
  rescue_from Myp::DecryptionKeyUnavailableError do |exception|
    redirect_to Myp.reentry_url(request)
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  def set_current_user
    User.current_user = current_user
    yield
  ensure
    User.current_user = nil
  end
  
  def set_current_user
    User.current_user = current_user
    yield
  ensure
    User.current_user = nil
  end
  
  def set_current_session
    request_accessor = instance_variable_get(:@_request)
    Thread.current[:current_session] = request_accessor.session
    yield
  ensure
    Thread.current[:current_session] = nil
  end
  
  def self.current_session
    Thread.current[:current_session]
  end
end
