class ClassCategoriesController < ApplicationController
  def new
    @class_category = ClassCategory.new
    @responsible_teachers = ResponsibleTeacher.all.map do |rt|
      rt.name
    end
  end

  def create
    @class_category = ClassCategory.new(class_category_params)

    if @class_category.save
      redirect_to class_category_path(@class_category)
    else
      render :new
    end
  end

  def show
    @class_category = ClassCategory.find(params[:id])
  end
end

private 

def class_category_params
  params.require(:class_category).permit(:name, :description, :responsible_teacher, :icon)
end