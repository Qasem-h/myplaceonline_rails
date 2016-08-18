class ApiController < ApplicationController
  include Rails.application.routes.url_helpers

  skip_authorization_check
  
  skip_before_action :verify_authenticity_token, only: [:debug]
  
  def index
  end
  
  def categories
    respond_to do |format|
      format.json { render json: Myp.categories_for_current_user(current_user, nil, true) }
    end
  end
  
  def search
    response = Myp.full_text_search(current_user, params[:q], category: params[:category], parent_category: params[:parent_category])
    respond_to do |format|
      format.json { render json: response }
    end
  end
  
  def randomString
    length = Myp::DEFAULT_PASSWORD_LENGTH
    if !params[:length].nil?
      length = params[:length].to_i
      if length <= 0 || length > 512
        length = Myp::DEFAULT_PASSWORD_LENGTH
      end
    end
    special = true
    if !params[:special].blank?
      special = params[:special].to_bool
    end
    possibilities = special ? Myp::POSSIBILITIES_ALPHANUMERIC_PLUS_SPECIAL : Myp::POSSIBILITIES_ALPHANUMERIC
    result = (0...length).map { possibilities[SecureRandom.random_number(possibilities.length)] }.join
    if special
      result[SecureRandom.random_number(result.length)] = Myp::POSSIBILITIES_SPECIAL[SecureRandom.random_number(Myp::POSSIBILITIES_SPECIAL.length)]
    end
    render json: {
      :randomString => result
    }
  end
  
  def subregions
    render partial: 'myplaceonline/subregionselect'
  end
  
  def renderpartial
    if !params[:partial].blank?
      if !params[:namePrefix].blank?
        updatedNamePrefix = params[:namePrefix][0..params[:namePrefix].rindex('[')-1]
        name = params[:namePrefix][params[:namePrefix].rindex('[')..-1].gsub("\[", "").gsub("\]", "")
        params[:namePrefix] = updatedNamePrefix
        params[:name] = name
        @params = params
        render(partial: 'myplaceonline/render_partial')
      else
        json_error("Name prefix not specified")
      end
    else
      json_error("Partial not specified")
    end
  end
  
  def quickfeedback
    if !current_user.nil? && !current_user.primary_identity.nil?
      user_input = params[:user_input]
      begin
        content = user_input + "\n\n" + params.except(:user_input).inspect
        UserMailer.send_support_email(
          current_user.email,
          "Quick Feedback",
          content,
          content
        ).deliver_now
        render json: {
          :result => true
        }
      rescue Exception => e
        render json: {
          :result => true,
          :error => e.to_s
        }
      end
    else
      render json: {
        :result => false
      }
    end
  end
  
  def debug
    
    body_markdown = "Message: " + params[:message] + "\n\n" + "Stack: " + params[:stack]
    
    Myp.send_support_email_safe("Browser Error", Myp.markdown_to_html(body_markdown.gsub("\n", "<br />\n")).html_safe, body_markdown)
    
    # So that a script kiddie doesn't DoS our email server
    sleep(1.0)
    
    render json: {
      :result => true
    }
  end
  
  def distinct_values
    table_name = params[:table_name]
    if !table_name.blank?
      column_name = params[:column_name]
      if !column_name.blank?
        model = Object.const_get(table_name)
        if !model.nil?
          if !model.column_names.index(column_name).nil?
            render json: model.find_by_sql(%{
              SELECT DISTINCT #{column_name}
              FROM #{model.table_name}
              WHERE identity_id = #{User.current_user.primary_identity.id}
              ORDER BY #{column_name}
            }).map{|x| x.send(column_name) }.delete_if{|x| x.blank?}.map{|x|
              {
                title: x,
                #link: "#",
                #count: Integer,
                #filtertext: String,
                #icon: String
              }
            }
          else
            json_error("column_name invalid")
          end
        else
          json_error("table_name invalid")
        end
      else
        json_error("column_name not specified")
      end
    else
      json_error("table_name not specified")
    end
  end
  
  def sleep_time
    if !current_user.nil? && current_user.admin?
      duration = params[:duration]
      if duration.blank?
        duration = 1
      else
        duration = duration.to_f
      end
      sleep(duration)
      render json: {
        :result => true,
        :message => "Slept for #{duration} s"
      }
    else
      render json: {
        :result => false
      }
    end
  end
  
  def hello_world
    render json: {
      message: "Hello World"
    }
  end
  
  def newfile
    result = {
      :result => false
    }
    urlpath = params[:urlpath]
    urlsearch = params[:urlpath]
    urlhash = params[:urlhash]
    
    Rails.logger.debug{"newfile urlpath: #{urlpath}"}
    
    if !urlpath.blank?
      spliturl = urlpath.split('/')
      if spliturl.length >= 3
        objclass = spliturl[1].singularize
        objid = spliturl[2]
        
        if !objid.index("?").nil?
          objid = objid[0..objid.index("?")-1]
        end
        
        if objid != "new"
          obj = Myp.find_existing_object(objclass, objid, false)
          authorize! :edit, obj

          # Alrighty, we've got the object and the user is authorized, so
          # now we can start the real work
          Rails.logger.debug{"obj: #{obj.inspect}"}
        else
          obj = nil
        end
        
        # We'll only have the file object, so just follow the path of params
        # for the object down to right above the file leaf node
        paramnode = params[objclass]
        prevnode = obj
        prevkey = nil
        prevkey_full = nil

        Rails.logger.debug{"initial node: #{paramnode}"}
        
        keepgoing = !paramnode.nil?
        iterations = 0
        while keepgoing && iterations < 500 do
          pair = paramnode.to_a[0]
          key = pair[0]
          val = paramnode = pair[1]
          iterations = iterations + 1
          
          Rails.logger.debug{"key: #{key}, val: #{val}"}
          
          if key.end_with?("_attributes")
            key = key[0..key.index("_attributes")-1]
          end
          
          # Regex checking for only digits
          if !!(key =~ /\A[-+]?[0-9]+\z/)
            ikey = key.to_i
            
            # If the next child is identity_file_attributes, then we know
            # we're done
            if val.has_key?("identity_file_attributes")
              
              if prevkey_full.end_with?("_attributes")
                
                Rails.logger.debug{"prevkey: #{prevkey}"}
                
                if !obj.nil?
                  prevkeyclass = Object.const_get(prevkey.singularize.to_s.camelize)

                  newfilewrapper = prevkeyclass.new(val)
                  
                  prevnode.send(prevkey) << newfilewrapper

                  Rails.logger.debug{"saving: #{prevnode.inspect}"}

                  prevnode.save!

                  newfile = newfilewrapper.identity_file
                else
                  newfile = IdentityFile.create(val["identity_file_attributes"])
                end

                Rails.logger.debug{"newfile: #{newfile.inspect}"}
              else
                raise "todo"
              end

              result = create_newfile_result(newfile, params)
              
              keepgoing = false

              Rails.logger.debug{"breaking loop"}
            else
              # Otherwise just index in
              prevnode = obj
              prevkey = key
              prevkey_full = pair[0]
              if !obj.nil?
                obj = obj[ikey]
                Rails.logger.debug{"nested indexed node: #{obj.inspect}"}
              end
            end
          else
            prevnode = obj
            prevkey = key
            prevkey_full = pair[0]
            
            if !obj.nil?
              obj = obj.send(key)
              Rails.logger.debug{"nested node: #{obj.inspect}"}
            end
          end
        end
        if !result[:result]
          # Just a simple add of a file
          if !params[:identity_file].nil?
            newfile = IdentityFile.create(params.require(:identity_file).permit(FilesController.param_names))
            Rails.logger.debug{"newfile final: #{newfile.inspect}"}
            result = create_newfile_result(newfile, params, singular: true)
          end
        end
      end
    end
    render json: result
  end
  
  def create_newfile_result(newfile, params, singular: false)
    items = [
      {
        type: "raw",
        value: "<p>" + MyplaceonlineController.helpers.image_tag(file_thumbnail_name_path(newfile, newfile.urlname, :h => newfile.thumbnail_hash), alt: newfile.display, title: newfile.display) + "</p>"
      },
      {
        type: "text",
        name: "identity_file_attributes.file_file_name",
        placeholder: t("myplaceonline.files.file_file_name"),
        value: newfile.file_file_name
      },
      {
        type: "textarea",
        name: "identity_file_attributes.notes",
        placeholder: t("myplaceonline.general.notes"),
        value: newfile.notes
      },
      {
        type: "hidden",
        name: "identity_file_attributes.id",
        value: newfile.id.to_s
      }
    ]
    
    if params[:position_field]
      items.push({
        type: "position",
        name: params[:position_field]
      })
    end

    {
      result: true,
      deletePlaceholder: I18n.t("myplaceonline.general.delete"),
      successNotification: I18n.t("myplaceonline.files.file_success", name: newfile.file_file_name),
      items: items,
      singular: singular,
      id: newfile.id
    }
  end
  
  def newitem
    redirect_to params[:newitemcategory] + "?prefill=" + params[:q]
  end
  
  def postal_code_search
    result = {
      result: false
    }
    q = params[:q]
    region = params[:region]
    if !q.blank? && q.length == 5 && !region.blank?
      zip_code = UsZipCode.where(zip_code: q).first
      if !zip_code.nil?
        result[:sub_region1] = zip_code.state
        result[:sub_region2] = zip_code.city
        result[:looked_up_postal_code] = I18n.t(
          "myplaceonline.locations.looked_up_postal_code",
          sub_region1: result[:sub_region1],
          sub_region2: result[:sub_region2],
          postal_code: q
        )
        result[:result] = true
      end
    end
    render json: result
  end

  def website_title
    result = {
      result: false
    }
    link = params[:link]
    begin
      info = Myp.website_info(link)
      if !info.nil?
        result[:title] = info[:title]
        result[:link] = info[:link]
        result[:result] = true
      end
    rescue Exception => e
      result[:error] = e.to_s
    end
    render json: result
  end

  protected
    def json_error(error)
      render json: {
        success: false,
        error: error
      }
    end
end
