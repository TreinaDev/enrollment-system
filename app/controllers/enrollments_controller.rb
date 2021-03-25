class EnrollmentsController < ApplicationController
  def new 
    @enrollment = Enrollment.new
    @customer = Customer.find_by(token: params[:token])
    @plans = Plan.all
    @payment_methods = PaymentMethod.all
  end
end