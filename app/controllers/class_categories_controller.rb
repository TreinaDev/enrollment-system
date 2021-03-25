class ClassCategoriesController < ApplicationController
  #before_action find_class_category, only: %i[edit, update, show, destroy]
  def index
    @class_categories = ClassCategory.all
  end

  def edit
    @class_category = ClassCategory.find(params[:id])
    get_all_teachers
  end

  def update
    @class_category = ClassCategory.find(params[:id])
    if @class_category.update(class_category_params)
      flash[:notice] = 'Categoria de Aula editada com sucesso.'
      redirect_to class_category_path(class_category_params)
    else
      get_all_teachers
      flash[:notice] = 'Ocorreram erros durante a edição, veja abaixo:'
      render 'edit'
    end
  end

  def new
    @class_category = ClassCategory.new
    if get_all_teachers.empty?
      flash[:notice] = 'Não podemos cadastrar esta categoria no momento'
    else
      get_all_teachers
    end
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

  def destroy
    @class_category = ClassCategory.find(params[:id])
    @class_category.destroy

    flash[:notice] = 'Categoria excluida com sucesso'
    redirect_to class_categories_path
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

  # def find_class_category
   #  @class_category = ClassCategory.find(params[:id])
  # end
end