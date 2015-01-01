require 'roo'

class PasswordsController < MyplaceonlineController
  skip_authorization_check :only => [:index, :new, :create, :import, :importodf]
  
  def import
  end
  
  def importodf
    Myp.ensure_encryption_key(session)
    @password = ""
    if request.post?
      if params.has_key?(:file)
        begin
          file = params[:file]
          @password = params[:password]
          
          ActiveRecord::Base.transaction do
            identity_file = IdentityFile.new()
            identity_file.identity = current_user.primary_identity
            identity_file.file = file
            if !@password.to_s.empty?
              identity_file.encrypted_password = Myp.encrypt_from_session(current_user, session, @password)
            end
            identity_file.save!
            
            # Try to read the file
            s = Roo::OpenOffice.new(identity_file.file.to_file.path, :password => @password, :file_warning => :ignore)
            
            @url = passwords_import_odf1_path(identity_file.id)
          end
        rescue Myp::DecryptionKeyUnavailableError
          @url = Myp.reentry_url(request)
        rescue StandardError => error
          Myp.log_error(logger, error)
          @error = error.to_s
        end
      else
        @error = t("myplaceonline.import.nofile")
      end
    end
  end
  
  def importodf1
    Myp.ensure_encryption_key(session)
    ifile = IdentityFile.find_by(identity: current_user.primary_identity, id: params[:id])
    if !ifile.nil?
      authorize! :manage, ifile
      s = Roo::OpenOffice.new(ifile.file.to_file.path, :password => ifile.get_password(session), :file_warning => :ignore)
      @sheets = s.sheets
    end
  end
  
  def importodf2
    Myp.ensure_encryption_key(session)
    ifile = IdentityFile.find_by(identity: current_user.primary_identity, id: params[:id])
    if !ifile.nil?
      authorize! :manage, ifile
      @encrypt = current_user.encrypt_by_default
      s = Roo::OpenOffice.new(ifile.file.to_file.path, :password => ifile.get_password(session), :file_warning => :ignore)
      @sheet = params[:sheet]
      s.default_sheet = s.sheets[s.sheets.index(@sheet)]
      @columns = Array.new
      for i in 1..s.last_column
        @columns.push(s.cell(s.first_row, i))
      end
    end
  end
  
  def importodf3
    Myp.ensure_encryption_key(session)
    ifile = IdentityFile.find_by(identity: current_user.primary_identity, id: params[:id])
    if !ifile.nil?
      authorize! :manage, ifile
      s = Roo::OpenOffice.new(ifile.file.to_file.path, :password => ifile.getPassword(session), :file_warning => :ignore)
      @sheet = params[:sheet]
      s.default_sheet = s.sheets[s.sheets.index(@sheet)]
      @columns = Array.new
      for i in 1..s.last_column
        @columns.push(s.cell(s.first_row, i))
      end
      
      last_row = params[:maximum_row]
      if last_row.to_s.empty?
        last_row = s.last_row.to_s
      end
      last_row = last_row.to_i
      imported_count = 0
      @encrypt = params[:encrypt] == "true"
      
      inputs = [
                :password_column, :service_name_column, :user_name_column,
                :notes_column, :notes_column_2, :account_number_column,
                :url_column,
                :secret_question_1_column, :secret_answer_1_column,
                :secret_question_2_column, :secret_answer_2_column,
                :secret_question_3_column, :secret_answer_3_column,
                :secret_question_4_column, :secret_answer_4_column,
                :secret_question_5_column, :secret_answer_5_column
               ]
      
      colindices = Hash.new
      inputs.each { |col| colindices[col] = get_plus1(@columns, params[col]) }
      
      if !colindices[:password_column].nil?
        if !colindices[:service_name_column].nil?
          ActiveRecord::Base.transaction do
            points = 0
            for i in (s.first_row + 1)..last_row
              password = Password.new
              password.identity_id = current_user.primary_identity.id

              password.password = s.cell(i, colindices[:password_column]).to_s
              password.password_finalize(@encrypt)

              password.name = s.cell(i, colindices[:service_name_column]).to_s
              if !colindices[:user_name_column].nil?
                password.user = s.cell(i, colindices[:user_name_column]).to_s
              end
              if !colindices[:notes_column].nil?
                if password.notes.to_s.empty?
                  password.notes = ""
                else
                  password.notes += "\n"
                end
                password.notes += s.cell(i, colindices[:notes_column]).to_s
              end
              if !colindices[:notes_column_2].nil?
                if password.notes.to_s.empty?
                  password.notes = ""
                else
                  password.notes += "\n"
                end
                password.notes += s.cell(i, colindices[:notes_column_2]).to_s
              end
              if !colindices[:account_number_column].nil?
                password.account_number = s.cell(i, colindices[:account_number_column]).to_s
              end
              if !colindices[:url_column].nil?
                password.url = s.cell(i, colindices[:url_column]).to_s
              end
              
              password.save!

              add_secret(s, i, password, @encrypt, colindices, :secret_question_1_column, :secret_answer_1_column)
              add_secret(s, i, password, @encrypt, colindices, :secret_question_2_column, :secret_answer_2_column)
              add_secret(s, i, password, @encrypt, colindices, :secret_question_3_column, :secret_answer_3_column)
              add_secret(s, i, password, @encrypt, colindices, :secret_question_4_column, :secret_answer_4_column)
              add_secret(s, i, password, @encrypt, colindices, :secret_question_5_column, :secret_answer_5_column)
              
              points = points + 1
            end
            Myp.modify_points(current_user, :passwords, points)
          end
          redirect_to passwords_path, :flash => { :notice => I18n.t("myplaceonline.passwords.imported_count", :count => imported_count) }
        else
          flash[:error] = t("myplaceonline.passwords.service_name_col_required")
          render :importodf2
        end
      else
        flash[:error] = t("myplaceonline.passwords.password_col_required")
        render :importodf2
      end
    end
  end
  
  def model
    Password
  end

  def display_obj(obj)
    obj.display
  end

  protected
    def sensitive
      true
    end

    def sorts
      ["lower(passwords.name) ASC", "lower(passwords.user) ASC"]
    end

    def create_presave
      @obj.password_finalize(@encrypt)
    end
    
    def update_presave
      @obj.password_finalize(@encrypt)
      @obj.password_secrets.each{|secret| secret.answer_finalize(@encrypt)}
    end

    def before_edit
      @encrypt = @obj.password_encrypted?
    end
  
    def obj_params
      params.require(:password).permit(
        :name,
        :user,
        :password,
        :url,
        :account_number,
        :notes,
        password_secrets_attributes: [:id, :question, :answer, :_destroy]
      )
    end
    
    def get_plus1(array, name)
      result = array.index(name)
      if !result.nil?
        result += 1
      end
      result
    end
    
    def add_secret(s, i, password, encrypt, colindices, question_col, answer_col)
      if !colindices[question_col].nil? && !colindices[answer_col].nil?
        secret = PasswordSecret.new
        secret.password = password
        secret.question = s.cell(i, colindices[question_col]).to_s
        secret.answer = s.cell(i, colindices[answer_col]).to_s
        secret.answer_finalize(encrypt)
      end
    end
end
