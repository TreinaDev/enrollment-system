class HomeController < ApplicationController
  def index
    @plans = Plan.active
    @payment_methods = PaymentMethod.all
  end
end
