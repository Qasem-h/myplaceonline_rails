class BadgesController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_authorization_check
  
  def n42
    render "42"
  end
end
