class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    self.resource.remember_me = true
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    
    # If we make it here, the login is succesful
    Myp.rememberPassword(session, params[:user][:password])
    
    #set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end
  
  def reenter
    if !user_signed_in?
      return redirect_to "/users/sign_in"
    end
    
    if params.has_key?(:redirect)
      @redirect = URI.parse(params[:redirect]).path
    end
    
    if request.post?
      pwd = params[:password]
      if current_user.valid_password?(pwd)
        Myp.rememberPassword(session, pwd)
        return redirect_to @redirect.nil? ? "/" : @redirect
      else
        flash.now[:error] = I18n.t("myplaceonline.errors.invalidpassword")
      end
    end
  end

  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    #set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
    yield if block_given?
    respond_to_on_destroy
  end
  
  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
