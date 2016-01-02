class MoneyBalancesController < MyplaceonlineController
  skip_authorization_check :only => MyplaceonlineController::DEFAULT_SKIP_AUTHORIZATION_CHECK + [:add, :list]

  def self.param_names(params)
    [
      Myp.select_or_create_permit(params, :contact_attributes, ContactsController.param_names),
      :notes,
      money_balance_items_attributes: [
        :id,
        :_destroy,
        :money_balance_item_name,
        :amount,
        :item_time,
        :invert,
        :notes
      ]
    ]
  end
  
  def list
    set_obj
  end
  
  def add
    set_obj
    # X paid a bill and Y either owes 100%, 50%, or some other percent
    @owner_paid = params[:owner_paid].to_bool
    if request.patch?
      if do_update
        return after_create_or_update
      end
    end
  end
  
  def who_paid_title(owner_paid)
    if owner_paid
      if @obj.current_user_owns?
        I18n.t("myplaceonline.money_balances.i_paid")
      else
        I18n.t("myplaceonline.money_balances.other_paid", { other: @obj.owner.display })
      end
    else
      if @obj.current_user_owns?
        I18n.t("myplaceonline.money_balances.other_paid", { other: @obj.contact.display })
      else
        I18n.t("myplaceonline.money_balances.i_paid")
      end
    end
  end
  
  def other_owed_name(owner_paid)
    if owner_paid
      if @obj.current_user_owns?
        I18n.t("myplaceonline.money_balances.x_owes", { x: @obj.contact.display })
      else
        I18n.t("myplaceonline.money_balances.i_owe")
      end
    else
      if @obj.current_user_owns?
        I18n.t("myplaceonline.money_balances.i_owe")
      else
        I18n.t("myplaceonline.money_balances.x_owes", { x: @obj.owner.display })
      end
    end
  end

  def other_display
    if @obj.current_user_owns?
      @obj.contact.display
    else
      @obj.owner.display
    end
  end

  def self.reject_if_blank(attributes)
    attributes.all?{|key, value|
      if key == "contact_attributes"
        ContactsController.reject_if_blank(value)
      else
        value.blank?
      end
    }
  end

  protected
    def sorts
      ["money_balances.updated_at DESC"]
    end

    def obj_params
      params.require(:money_balance).permit(
        MoneyBalancesController.param_names(params[:money_balance])
      )
    end
end