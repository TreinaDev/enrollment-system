class EnrollmentsController < ApplicationController
  def index
    @enrollments = Enrollment.all
  end

  def new
    @enrollment = Enrollment.new
    @customer = Customer.find_by(token: params[:token])
    @selected_plan = params[:plan]
    @plans = Plan.all
    @payment_methods = PaymentMethod.all
  end

  def create
    @enrollment = Enrollment.new(allowed_params)
    if @enrollment.save
      @enrollment.approve_payment!
      redirect_to Rails.configuration.api['classroom_app']
    else
      @customer = Customer.find_by(token: params[:customer])
      @plans = Plan.all
      @payment_methods = PaymentMethod.all
      render :new
    end
  end

  def destroy
    @enrollment = Enrollment.find(params[:id])
    @enrollment.update!(status: :inactive)
    redirect_to enrollments_path
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
