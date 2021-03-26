class ClassCategoriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :define_class_category, only: %i[edit update show destroy]
  before_action :all_teachers, only: %i[edit]
  def index
    @class_categories = ClassCategory.all
  end

  def edit; end

  def update
    if @class_category.update(class_category_params)
      redirect_to class_category_path(class_category_params), notice: t('.success')
    else
      all_teachers
      flash.now[:notice] = t('.error')
      render('edit')
    end
  end

  def new
    @class_category = ClassCategory.new
    if all_teachers.empty?
      flash.now[:notice] = t('.error')
    else
      all_teachers
    end
  end

  def create
    @class_category = ClassCategory.new(class_category_params)

    if @class_category.save
      redirect_to class_category_path(@class_category)
    else
      flash.now[:notice] = t('.error')
      all_teachers
      render :new
    end
  end

  def show; end

  def destroy
    @class_category.destroy
    redirect_to class_categories_path, notice: t('.success')
  end

  private

  def class_category_params
    params.require(:class_category).permit(:name, :description, :responsible_teacher, :icon)
  end

  def all_teachers
    @responsible_teachers = ResponsibleTeacher.all.map(&:name)
  end

  def define_class_category
    @class_category = ClassCategory.find(params[:id])
  end

  def authenticate_admin!
    current_user&.admin?
  end
end
