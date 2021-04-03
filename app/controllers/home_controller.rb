class HomeController < ApplicationController
  def index
    @plans = Plan.all
    @payment_methods = PaymentMethod.all
    @customer = Customer.find_by(token: params[:token])
  end
end
