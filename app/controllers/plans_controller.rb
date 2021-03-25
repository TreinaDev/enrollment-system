class PlansController < ApplicationController
  before_action :authenticate_user!, only: %i[:create, :new]
  def new
    @plan = Plan.new
    @categories = ClassCategory.all
  end

  def show
    @plan = Plan.find(params[:id])
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

  private

  def plan_params
    params.require(:plan).permit(:name,
                              :monthly_rate,
                              :monthly_class_limit,
                              :description,
                              class_category_ids: [])
end
end
