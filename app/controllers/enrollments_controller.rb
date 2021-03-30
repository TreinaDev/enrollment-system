class EnrollmentsController < ApplicationController
  def new
    @enrollment = Enrollment.new
    @customer = Customer.find_by(token: params[:token])
    @plans = Plan.all
    @payment_methods = PaymentMethod.all
  end

  def create
    @enrollment = Enrollment.new(allowed_params)
    if @enrollment.save
      @enrollment.approve_payment!
      redirect_to root_path
    else
      @customer = Customer.find_by(token: params[:customer])
      @plans = Plan.all
      @payment_methods = PaymentMethod.all
      render :new
    end
  end

  private

  def allowed_params
    {
      customer: Customer.find_by(token: params[:customer]),
      plan: Plan.find_by(id: params[:plan]),
      payment_method: params[:method]
    }
  end
end
