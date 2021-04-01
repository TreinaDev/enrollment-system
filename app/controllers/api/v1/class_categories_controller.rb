module Api
  module V1
    class ClassCategoriesController < ApiController
      def index
        class_categories = ClassCategory.all
        return render status: :not_found, json: "{ msg: #{I18n.t('.error')} }" if class_categories.empty?

        render json: class_categories, status: :ok
      end

      def show
        class_category = ClassCategory.find_by(params[:id])
        return render status: :not_found, json: "{ msg: #{I18n.t('.error')} }" if class_category.nil?

        render json: class_category.as_json(except: %i[created_at updated_at icon]), status: :ok
      end
    end
  end
end
