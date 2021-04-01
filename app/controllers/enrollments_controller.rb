class EnrollmentsController < ApplicationController
  def show
    @enrollment = Enrollment.find(params[:id])
    @customer = @enrollment.customer
  end
  
  def inactivate
    @enrollment = Enrollment.find(params[:id])
    @enrollment.inactive!
    redirect_to @enrollment
  end
end

