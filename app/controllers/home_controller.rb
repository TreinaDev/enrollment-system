class HomeController < ApplicationController
  def index
    @plans = Plan.where('status == ?', 0)
    @payment_methods = PaymentMethod.all
  end
end
