module Api
  module V1
    class EnrollmentsController < ApiController
      def show
        customer = Customer.find_by(token: params[:id])
        return render status: :not_found, json: '{"msg":"Token não encontrado"}' if customer.nil?

        enrollment = Enrollment.find_by(customer_id: customer.id)
        return render status: :ok, json: '{"msg": "Aluno não tem um plano vinculado" }' if enrollment.inactive?

        render json: enrollment.as_json(only: %i[status enrolled_at],
                                        include: {
                                          plan: { except: %i[created_at updated_at],
                                                  include:
                                          { class_categories: { only: %i[id name] } } }
                                        }), status: :ok
      end
    end
  end
end
