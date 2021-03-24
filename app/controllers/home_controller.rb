class HomeController < ApplicationController
  def index
    @current_user = CurrentUser.login.first
    @plans = Plan.all
    @payment_methods = PaymentMethod.all
  end
end
