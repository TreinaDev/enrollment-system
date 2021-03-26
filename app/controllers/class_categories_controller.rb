class ClassCategoriesController < ApplicationController
  before_action :find_class_category, only: %i[edit update show destroy]
  before_action :authenticate_user!
  def index
    @class_categories = ClassCategory.all
  end

  def edit
    all_teachers
  end

  def update
    if @class_category.update(class_category_params)
      flash[:notice] = 'Categoria de Aula editada com sucesso.'
      redirect_to class_category_path(class_category_params)
    else
      all_teachers
      flash[:notice] = 'Ocorreram erros durante a edição, veja abaixo:'
      render 'edit'
    end
  end

  def new
    @class_category = ClassCategory.new
    if all_teachers.empty?
      flash[:notice] = 'Não podemos cadastrar esta categoria no momento'
    else
      all_teachers
    end
  end

  def create
    @class_category = ClassCategory.new(class_category_params)

    if @class_category.save
      redirect_to class_category_path(@class_category)
    else
      flash[:notice] = 'Ocorreram erros durante o cadastro, veja abaixo:'
      all_teachers
      render :new
    end
  end

  def show; end

  def destroy
    @class_category.destroy

    flash[:notice] = 'Categoria excluida com sucesso'
    redirect_to class_categories_path
  end

  private

  def class_category_params
    params.require(:class_category).permit(:name, :description, :responsible_teacher, :icon)
  end

  def all_teachers
    @responsible_teachers = ResponsibleTeacher.all.map(&:name)
  end

  def find_class_category
    @class_category = ClassCategory.find(params[:id])
  end
end
