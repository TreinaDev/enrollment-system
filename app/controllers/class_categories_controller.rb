class ClassCategoriesController < ApplicationController
  def new
    @class_category = ClassCategory.new
    get_all_teachers
  end

  def create
    @class_category = ClassCategory.new(class_category_params)

    if @class_category.save
      redirect_to class_category_path(@class_category)
    else
      flash[:notice] = 'Ocorreram erros durante o cadastro, veja abaixo:'
      get_all_teachers
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

  def get_all_teachers
    @responsible_teachers = ResponsibleTeacher.all.map do |rt|
      rt.name
    end
  end