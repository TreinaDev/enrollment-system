class HomeController < ApplicationController
  def index
    @plans = Plan.all
    @payment_methods = PaymentMethod.all
  end
end
