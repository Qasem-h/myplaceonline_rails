class PeriodicPaymentsController < MyplaceonlineController
  skip_authorization_check :only => MyplaceonlineController::DEFAULT_SKIP_AUTHORIZATION_CHECK + [:monthly_total]

  def monthly_total
    @total = 0
    all.each do |x|
      if Myp.includes_today?(x.started, x.ended)
        if x.date_period == 0
          @total += x.payment_amount
        elsif x.date_period == 1
          @total += x.payment_amount / 12
        end
      end
    end
  end

  def model
    PeriodicPayment
  end

  def display_obj(obj)
    obj.display
  end

  protected
    def sorts
      ["lower(periodic_payments.periodic_payment_name) ASC"]
    end

    def obj_params
      params.require(:periodic_payment).permit(
        :periodic_payment_name,
        :notes,
        :started,
        :ended,
        :date_period,
        :payment_amount
      )
    end
end
