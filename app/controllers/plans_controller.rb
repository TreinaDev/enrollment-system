class PlansController < ApplicationController
  before_action :authenticate_user!, only: %i[create new]

  CLASSROOM_URL_APP = 'https://localhost:3000/'.freeze

  def new
    @plan = Plan.new
    @categories = ClassCategory.all
  end

  def show
    @plan = Plan.find(params[:id])
    session[:token] = params[:token]
  end

  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      redirect_to plan_path(@plan)
    else
      render 'new'
    end
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update
    @plan = Plan.find(params[:id])
    if @plan.update(plan_params)
      redirect_to plan_path(@plan)
    else
      render 'edit'
    end
  end

  def inactivate
    @plan = Plan.find(params[:id])
    @plan.inactive!
    flash[:notice] = 'Plano inativado com sucesso'
    redirect_to root_path
  end

  def buy
    @plan = Plan.find(params[:id])
    @customer = Customer.find_by(token: session[:token])
    if @customer.nil?
      render 'show'
    else
      @customer.hire_plan!(@plan)
      redirect_to CLASSROOM_URL_APP
    end
  end

  def new_dependent
    customer = Customer.find_by(token: session[:token])
    plan = Plan.find(params[:id])
    @enrollment = Enrollment.where('plan.id = ? AND customer.token = ?',
                                   plan.id, customer.token)
  end

  private

  def plan_params
    params.require(:plan).permit(:name,
                                 :monthly_rate,
                                 :monthly_class_limit,
                                 :description,
                                 :max_dependents,
                                 class_category_ids: [])
  end
end
