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

      def show
        customer = Customer.find_by(token: params[:id])
        return render status: :not_found, json: '{"msg":"Token não encontrado"}' if customer.nil?

        enrollment = Enrollment.find_by(customer_id: customer.id)
        plan = Plan.find_by(id: enrollment.plan.id)
        return render status: :ok, json: '{"msg": "Aluno não tem um plano vinculado" }' if enrollment.inactive?

        render json: plan.as_json(except: %i[created_at updated_at],
                                  include: {
                                    class_categories: { only: %i[id name] }
                                  }), status: :ok
      end
    end
  end
end
