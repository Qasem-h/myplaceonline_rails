class MyplaceonlineController < ApplicationController
  before_action :before_all_actions
  before_action :set_obj, only: [:show, :edit, :update, :destroy]
  
  DEFAULT_SKIP_AUTHORIZATION_CHECK = [:index, :new, :create, :destroy_all]
  
  skip_authorization_check :only => MyplaceonlineController::DEFAULT_SKIP_AUTHORIZATION_CHECK

  respond_to :html, :json

  def index
    deny_guest
    
    if sensitive
      Myp.ensure_encryption_key(session)
    end
    
    if has_category && params[:myplet].nil?
      Myp.visit(current_user, category_name)
    end
    
    @offset = params[:offset].nil? ? get_default_offset : params[:offset].to_i
    if @offset < 0
      @offset = 0
    end

    if params[:perpage].nil?
      @perpage = 20
      if !current_user.items_per_page.nil?
        @perpage = current_user.items_per_page.to_i
      end
    else
      @perpage = params[:perpage].to_i
    end
    
    @count_all = all(strict: true).count
    
    cached_all = all
    @count = cached_all.count
    if @perpage <= 0
      @perpage = @count
    end

    @objs = cached_all.offset(@offset).limit(@perpage).order(sorts)
    
    # If the controller wants to show top items (`additional_items?` returns
    # true), then the only other thing we'll check is if there's more than
    # a few items
    if additional_items? && @count > 1
      @additional_items = additional_items
    end

    index_pre_respond()

    set_parent
    
    # Save off any query parameters which might be used by AJAX callbacks to
    # index.json.erb (for example, for a full item search)
    @query_params_part = Myp.query_parameters_uri_part(request)
    @query_params_part_all = ""
    if @query_params_part.blank?
      @query_params_part_all = "?perpage=0"
    else
      @query_params_part_all = "?" + @query_params_part + "&perpage=0"
    end
    
    @myplet = params[:myplet]
    if !@myplet
      respond_with(@objs)
    else
      indexmyplet
      render action: "index", layout: "myplet"
    end
  end
  
  def set_parent
    if nested
      parent_id = parent_model_last.table_name.singularize.downcase + "_id"
      @parent = Myp.find_existing_object(parent_model_last, params[parent_id], false)
    end
  end

  def show
    if sensitive
      Myp.ensure_encryption_key(session)
    end
    @nested_show = params[:nested_show]
    before_show
    @myplet = params[:myplet]
    if @nested_show
      render action: "show", layout: "blank"
    elsif !@myplet
      respond_with(@obj)
    else
      showmyplet
      render action: "show", layout: "myplet"
    end
  end
  
  def new
    deny_guest
    
    if !insecure
      Myp.ensure_encryption_key(session)
    end
    @obj = Myp.new_model(model, params)
    set_parent
    @url = new_path
    if request.post?
      create
    else
      new_prerespond
      Rails.logger.debug{"myplaceonline_controller new: #{@obj.inspect}"}
      respond_with(@obj)
    end
  end

  def edit
    deny_guest
    
    Myp.ensure_encryption_key(session)
    @url = obj_path(@obj)
    edit_prerespond
    respond_with(@obj)
  end
  
  def create
    deny_guest
    
    Rails.logger.debug{"create"}
    if !insecure
      Myp.ensure_encryption_key(session)
    end
    ActiveRecord::Base.transaction do
      begin
        if @parent.nil?
          Permission.current_target = @obj
        else
          Permission.current_target = @parent
        end
        
        begin
          p = obj_params
          Rails.logger.debug{"Permitted parameters: #{p.inspect}"}
          @obj = model.new(p)
        rescue ActiveRecord::RecordNotFound => rnf
          raise Myp::CannotFindNestedAttribute, rnf.message + " (code needs attribute setter override?)"
        end
        
        if do_check_double_post
          return after_create_or_update
        end
        
        if nested
          parent_name = parent_model_last.table_name.singularize.downcase
          parent_id = parent_model_last.table_name.singularize.downcase + "_id"
          new_parent = Myp.find_existing_object(parent_model_last, params[parent_id], false)
          Rails.logger.debug{"Setting parent #{parent_id} to #{new_parent.inspect}"}
          @obj.send("#{parent_name}=", new_parent)
        end
        
        save_result = @obj.save
        
        Rails.logger.debug{"Saved #{save_result.to_s} for #{@obj.inspect}"}
        
        if save_result
          
          Rails.logger.debug{"Parent: #{@parent.inspect}, current owns? #{@obj.current_user_owns?}"}
          
          if !@parent.nil? && !@obj.current_user_owns?
            existing_permission = Permission.where(
              user_id: User.current_user.id,
              subject_class: Myp.model_to_category_name(@parent.class),
              subject_id: @parent.id
            ).first
            
            Rails.logger.debug{"Existing permission: #{existing_permission.inspect}"}
            
            if !existing_permission.nil?
              Permission.new(
                identity_id: existing_permission.identity_id,
                user_id: existing_permission.user_id,
                subject_class: Myp.model_to_category_name(model),
                subject_id: @obj.id,
                action: existing_permission.action
              ).save!
            end
          end
          if has_category
            Myp.add_point(current_user, category_name, session)
          end
          after_create
          return after_create_or_update
        else
          return render :new
        end
      ensure
        Permission.current_target = nil
      end
    end
  end
  
  def update
    deny_guest
    
    if do_update
      return after_create_or_update
    else
      return render :edit
    end
  end
  
  def do_check_double_post
    
    # Don't check this in test because test might quickly be creating items
    if !Rails.env.test?
      # If an item of this model type was created within the last few seconds
      # then just assume it was a double POST
      last_item = model
        .where("identity_id = ?", current_user.primary_identity.id)
        .order("created_at DESC")
        .limit(1)
        .first
        
      if !last_item.nil?
        if last_item.created_at + 3.seconds >= Time.now.utc
          @obj = last_item
          Rails.logger.debug{"Detected double post"}
          return true
        end
      end
    end
    
    false
  end
  
  def do_update(check_double_post: false)
    update_security
    
    ActiveRecord::Base.transaction do
      begin
        if @parent.nil?
          Permission.current_target = @obj
        else
          Permission.current_target = @parent
        end

        begin
          @obj.assign_attributes(obj_params)
        rescue ActiveRecord::RecordNotFound => rnf
          raise Myp::CannotFindNestedAttribute, rnf.message + " (code needs attribute setter override?)"
        end
        
        if check_double_post
          if do_check_double_post
            return true
          end
        end
        
        do_update_before_save

        @obj.save
      ensure
        Permission.current_target = nil
      end
    end
  end
  
  def do_update_before_save
  end
  
  def after_create_or_update
    respond_to do |format|
      format.html { redirect_to_obj }
      format.js { render :saved }
    end
  end
  
  def redirect_to_obj
    redirect_to obj_path
  end

  def destroy
    deny_guest
    
    Myp.ensure_encryption_key(session)
    ActiveRecord::Base.transaction do
      @obj.destroy
      if has_category
        Myp.subtract_point(current_user, category_name, session)
      end
    end

    redirect_to index_path
  end

  def destroy_all
    Myp.ensure_encryption_key(session)
    deny_guest
    ActiveRecord::Base.transaction do
      all.each do |obj|
        authorize! :destroy, obj
        obj.destroy
        if has_category
          Myp.subtract_point(current_user, category_name, session)
        end
      end
    end

    if nested
      set_parent
      redirect_to url_for(@parent),
          :flash => { :notice => I18n.t("myplaceonline.general.all_deleted") }
    else
      redirect_to index_path,
          :flash => { :notice => I18n.t("myplaceonline.general.all_deleted") }
    end
  end

  def path_name
    model.model_name.singular.to_s.downcase
  end
  
  def paths_name
    path_name.pluralize
  end
  
  def second_path_name
    raise NotImplementedError
  end
  
  def category_name
    model.table_name
  end
    
  def display_obj(obj)
    result = obj.display
    if result.nil?
      result = HTMLEntities.new.encode(obj.to_s)
    end
    result
  end
  
  def use_bubble?
    false
  end
  
  def display_obj_bubble(obj)
    if use_bubble?
      " <span class=\"ui-li-count\">#{bubble_text(obj)}</span>"
    else
      ""
    end
  end
  
  def bubble_text(obj)
    ""
  end
    
  def model
    Object.const_get(self.class.name.gsub(/Controller$/, "").singularize)
  end
  
  def index_path
    send(paths_name + "_path")
  end
  
  def obj_path(obj = @obj)
    if nested
      send(path_name + "_path", obj.send(parent_model.table_name.singularize.downcase), obj)
    else
      send(path_name + "_path", obj)
    end
  end
  
  def edit_obj_path(obj = @obj)
    if nested
      send("edit_" + path_name + "_path", obj.send(parent_model.table_name.singularize.downcase), obj)
    else
      send("edit_" + path_name + "_path", obj)
    end
  end
  
  def show_path(obj)
    if nested
      send("#{path_name}_path", obj.send(parent_model.table_name.singularize.downcase), obj)
    else
      send("#{path_name}_path", obj)
    end
  end
  
  def new_path(context = nil)
    send("new_" + path_name + "_path")
  end
  
  def destroy_all_path(context = nil)
    if nested
      set_parent
      send("#{path_name.pluralize}_destroy_all_path", @parent)
    else
      send("#{path_name.pluralize}_destroy_all_path")
    end
  end
  
  # See myplaceonline_final.js, ajax:remotipartSubmit
  # 
  # If new/update succeeds, navigate JS returned in:
  # views/myplaceonline/saved.js.erb
  def may_upload
    false
  end
  
  def has_items
    @objs.length > 0 || (!@objs2.nil? && @objs2.length > 0)
  end

  def second_list_before
    false
  end
  
  def back_to_all_name
    I18n.t("myplaceonline.category." + category_name)
  end
  
  def back_to_all_path
    index_path
  end
  
  def add_another_name
    I18n.t("myplaceonline.general.add_another")
  end
  
  def second_list_icon(obj = nil)
    nil
  end
  
  def show_add
    true
  end
  
  def show_index_footer
    true
  end
  
  def how_many_top_items
    additional_items_max_items
  end
  
  def show_created_updated
    true
  end
  
  def form_path
    paths_name + "/form"
  end
  
  def new_title
    I18n.t("myplaceonline.general.add") + " " + I18n.t("myplaceonline.category." + category_name).singularize
  end
  
  def data_split_icon
    "check"
  end
  
  def split_link(obj)
    ""
  end
  
  def new_save_text
    I18n.t("myplaceonline.general.save") + " " + I18n.t("myplaceonline.category." + category_name).singularize
  end
  
  def index_destroy_all_link?
    false
  end
  
  def search_index_name
    category_name
  end
  
  protected
  
    def deny_guest
      if current_user.guest?
        raise CanCan::AccessDenied
      end
    end
  
    def obj_params
      raise NotImplementedError
    end
    
    def sorts
      raise NotImplementedError
    end
    
    def sensitive
      false
    end
    
    def insecure
      false
    end
    
    def before_all_actions
      if requires_admin && !current_user.admin?
        raise CanCan::AccessDenied
      end
    end
    
    def all_additional_sql(strict)
      nil
    end
    
    def all_joins
      nil
    end
    
    def all_includes
      nil
    end
    
    def additional_items?
      model.new.respond_to?("visit_count")
    end
  
    def additional_items_min_visit_count
      2
    end
    
    def additional_items_max_items
      5
    end

    # strict: true allows getting all items (usually for a total count)
    def all(strict: false)
      initial_or = ""
      can_read_others = Permission.where(
        "user_id = ? and subject_class = ? and (action & #{Permission::ACTION_MANAGE} != 0 or action & #{Permission::ACTION_READ} != 0)",
        current_user.id,
        category_name
      ).to_a.map{|p| p.subject_id}.join(",")
      if !can_read_others.blank?
        initial_or = " or #{model.table_name}.id in (#{can_read_others})"
      end
      additional = all_additional_sql(strict)
      if additional.nil?
        additional = ""
      end
      if nested
        parent_id = parent_model_last.table_name.singularize.downcase + "_id"
        additional += " AND #{model.table_name}.#{parent_id} = #{ActionController::Base.helpers.sanitize(params[parent_id.to_sym])}"
      end
      model.includes(all_includes).joins(all_joins).where(
        "(#{model.table_name}.identity_id = ? #{initial_or}) #{additional}",
        current_user.primary_identity.id
      )
    end
    
    def additional_items(strict: false)
      additional = all_additional_sql(strict)
      if additional.nil?
        additional = ""
      end
      model.includes(all_includes).joins(all_joins).where(
        model.table_name + ".identity_id = ? and " + model.table_name + ".visit_count >= ? " + additional,
        current_user.primary_identity,
        additional_items_min_visit_count
      ).limit(additional_items_max_items).order(model.table_name + ".visit_count DESC")
    end

    def set_obj(action = nil)
      if action.nil?
        action = action_name
      end
      if nested
        parent_id = parent_model_last.table_name.singularize.downcase + "_id"
        @parent = Myp.find_existing_object(parent_model_last, params[parent_id], false)
        @obj = model.where("id = ? and #{parent_id} = ?", params[:id].to_i, params[parent_id.to_sym].to_i).take!
      else
        @obj = model.find(params[:id].to_i)
      end
      authorize! action.to_sym, @obj
    end
    
    def before_show
      # Use update_column because we don't want updated_at to be updated
      if params[:myplet].nil?
        MyplaceonlineController.increment_visit_count(@obj)
      end
    end
    
    def self.increment_visit_count(obj)
      if obj.respond_to?("visit_count")
        if obj.visit_count?
          obj.update_column(:visit_count, obj.visit_count + 1)
        else
          obj.update_column(:visit_count, 1)
        end
      end
    end
    
    def has_category
      true
    end
    
    def index_pre_respond()
      if request.original_url().include?(".json")
        filter_json_index_search()
      end
    end
    
    def filter_json_index_search()
    end
    
    def update_security
      Myp.ensure_encryption_key(session)
    end
    
    def indexmyplet
    end
    
    def showmyplet
    end
    
    def nested
      false
    end
    
    def parent_model
      nil
    end
    
    def parent_model_list
      result = parent_model
      if !result.instance_of?(Array)
        if !result.nil?
          result = [result]
        else
          result = []
        end
      end
      result
    end
    
    def parent_model_last
      result = parent_model
      if result.instance_of?(Array)
        result = result[result.length - 1]
      end
      result
    end

    def edit_prerespond
    end
    
    def new_prerespond
    end
    
    def requires_admin
      false
    end
    
    def after_create
    end
    
    def get_default_offset
      0
    end
end
