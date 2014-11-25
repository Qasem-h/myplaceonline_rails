require 'roo'

class PasswordsController < ApplicationController
  def index
    Myp.visit(current_user, :passwords)
    @passwords = Password.where(identity_id: current_user.primary_identity.id)
  end
  
  def new
    @url = new_password_path
    if request.post?
      create
    else
      @password = Password.new
    end
  end
  
  def create
    @password = Password.new(password_params)
    ActiveRecord::Base.transaction do
      @password.identity_id = current_user.primary_identity.id
      
      # Only bother checking encryption if the password is valid
      # (i.e. the save will fail)
      if @password.valid?
        if !encryptIfNeeded(@password)
          return render :new
        end
      end
      
      if @password.save
        Myp.addPoint(current_user, :passwords)
        redirect_to @password
      else
        render :new
      end
    end
  end
  
  def show
    @password = findPassword
  end
  
  def edit
    @password = findPassword
    @password.password = @password.getPassword(session)
    @url = @password
  end
  
  def update
    @password = findPassword

    ActiveRecord::Base.transaction do
      
      @password.attributes=(password_params)
      
      # Only bother checking encryption if the password is valid
      # (i.e. the save will fail)
      if @password.valid?
        # if there's an encrypted value and the user unchecked encrypt
        # then we can delete the encrypted value
        if !@password.is_encrypted_password && !@password.encrypted_password.nil?
          @password.encrypted_password.destroy
        end
        if !encryptIfNeeded(@password)
          return render :edit
        end
      end

      if @password.save
        redirect_to @password
      else
        render :edit
      end
    end
  end
  
  def destroy
    @article = findPassword
    ActiveRecord::Base.transaction do
      @article.destroy
      Myp.subtractPoint(current_user, :passwords)
    end

    redirect_to passwords_path
  end
  
  def import
  end
  
  def importodf
    if request.post?
      if params.has_key?(:file)
        begin
          file = params[:file]
          identity_file = IdentityFile.new()
          identity_file.identity = current_user.primary_identity
          identity_file.file = file
          identity_file.save
          @url = passwords_import_odf1_path(identity_file.id)
        rescue StandardError => error
          logger.error(error.inspect)
          @error = error.inspect
        end
      else
        @error = t("myplaceonline.import.nofile")
      end
    end
  end
  
  def importodf1
    ifile = IdentityFile.find_by(identity: current_user.primary_identity, id: params[:id])
    if !ifile.nil?
      begin
        s = Roo::OpenOffice.new(ifile.file.path)
        puts s.sheets.inspect
      rescue StandardError => error
        logger.error(error.inspect)
        @error = error.inspect
      end
    end
  end
  
  private
    def password_params
      # Without the require call, render new in create doesn't persist values
      params.require(:password).permit(:name, :user, :password, :is_encrypted_password)
    end

    def findPassword
      return Password.find_by(id: params[:id], identity_id: current_user.primary_identity.id)
    end
    
    def encryptIfNeeded(password)
      if password.is_encrypted_password
        encrypted_value = Myp.encryptFromSession(current_user, session, password.password)
        if encrypted_value.save
          password.encrypted_password = encrypted_value
          password.password = nil
        else
          flash.now[:error] = t("myplaceonline.errors.couldnotencrypt")
          return false
        end
      end
      return true
    end
end
