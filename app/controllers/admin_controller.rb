class AdminController < ApplicationController

  skip_before_action :do_authenticate_user
  skip_authorization_check

  before_action :check_authorization
  
  def test
    render json: {
      :test => "Hello World"
    }
  end
  
  def ensure_pending_all_users
    CalendarItemReminder.ensure_pending_all_users
    render json: {
      :success => true
    }
  end
  
  def check_authorization
    Rails.logger.info{"AdminController check_authorization IP: #{request.remote_ip}"}
    if Rails.env.production?
      if ENV["SECRET_KEY_BASE"] != params[:password]
        raise CanCan::AccessDenied.new("Not authorized")
      end
    end
  end
  
  def create_test_job
    TestJob.perform_later("hello world")
    render json: {
      :success => true
    }
  end
end
