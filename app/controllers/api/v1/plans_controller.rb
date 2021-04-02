module Api
  module V1
    class PlansController < ApiController
      def index
        plans = Plan.all
        return render status: :not_found, json: '{"msg": "Não existem planos" }' if plans.empty?

        render json: plans.as_json(except: %i[created_at updated_at],
                                   include: {
                                     class_categories: { only: %i[id name] }
                                   }), status: :ok
      end
    end
  end
end
