class PlansController < ApplicationController
  def new
    @plan = Plan.new
    @plans = Plan.all
    @categories = ClassCategory.all
  end

  def show
    @plan = Plan.find(params[:id])
  end

  def create
    plan_params = params.require(:plan).permit(:name,
                                               :monthly_rate,
                                               :monthly_class_limit,
                                               :description,
                                               class_category_ids: [])
    @plan = Plan.new(plan_params)
    if @plan.save
      redirect_to plan_path(@plan)
    else
      render 'new'
    end
  end
end
