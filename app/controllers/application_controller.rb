class ApplicationController < ActionController::Base
  respond_to :html, :json
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # By default, all pages require authentication unless the controller has
  #   skip_before_filter :do_authenticate_user
  #before_action :authenticate_user!
  before_action :do_authenticate_user
  
  around_filter :around_request
  
  #after_filter do puts "Response: " + response.body end
  
  before_filter :set_time_zone
  
  check_authorization
  
  rescue_from StandardError, :with => :catchall
  
  utf8_enforcer_workaround
  
  def do_authenticate_user
    Rails.logger.debug{"do_authenticate_user entry"}

    catch_result = catch(:warden) do
      Rails.logger.debug{"calling authenticate_user!"}
      authenticate_user!
      Rails.logger.debug{"returned successfully"}
    end
    
    Rails.logger.debug{"catch_result: #{catch_result.inspect}"}

    # If catch_result is a Hash, then we assume it's {scope: :user} and
    # it's somebody trying to access a resource; otherwise, it might just be
    # somebody failing to login for some reason (e.g. password) and we
    # let that fall through (re-throw not needed)
    
    if catch_result.is_a?(Hash)
      # authenticate_user! failed
      
      Rails.logger.debug{"Setting user to guest: #{User.guest.inspect}"}
      
      warden.set_user(User.guest, {run_callbacks: false})

    #else
    #  throw :warden, catch_result

    end
  end

  def catchall(exception)
    Rails.logger.debug{"catchall: #{exception.inspect}"}
    if exception.is_a?(Myp::DecryptionKeyUnavailableError)
      redirect_to Myp.reentry_url(request)
    elsif exception.is_a?(CanCan::AccessDenied)
      redirect_to root_url, :alert => exception.message
    elsif exception.is_a?(Myp::SuddenRedirectError)
      redirect_to exception.path
    else
      Myp.handle_exception(exception, session[:myp_email], request)
      respond_to do |type|
        #type.xml { render :template => "errors/error_404", :status => 500 }
        type.all { render :text => exception.to_s, :status => 500 }
      end
      true
    end
  end
  
  def around_request
    Rails.logger.debug{"application_controller around_request entry #{request.referer}"}
    begin
      ExecutionContext.push
      # only do this once per request
      if MyplaceonlineExecutionContext.user.nil?
        request_accessor = instance_variable_get(:@_request)
        Rails.logger.debug{"Setting User.current_user: #{current_user.inspect}"}
        MyplaceonlineExecutionContext.user = current_user
        MyplaceonlineExecutionContext.session = request_accessor.session
        if !current_user.nil?
          request_accessor.session[:myp_email] = current_user.email
        end
        MyplaceonlineExecutionContext.request = request_accessor
      end
      
      yield
    ensure
      ExecutionContext.pop
      Rails.logger.debug{"application_controller around_request exit"}
    end
  end
  
  def self.current_session
    MyplaceonlineExecutionContext.session
  end
  
  def self.current_request
    MyplaceonlineExecutionContext.request
  end
  
  def set_time_zone
    if !current_user.nil? && !current_user.timezone.blank?
      begin
        Time.zone = current_user.timezone
      rescue Exception => e
        Myp.warn("Invalid time zone #{Myp.error_details(e)}")
      end
    end
  end

  private
    # https://github.com/CanCanCommunity/cancancan/wiki/Accessing-request-data
    def current_ability
      @current_ability ||= Ability.new(current_user, request)
    end
end
