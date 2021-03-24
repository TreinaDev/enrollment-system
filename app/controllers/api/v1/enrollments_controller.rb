module Api
  module V1
    class EnrollmentsController < ApiController
      def create
        enrollment = Enrollment.create!(allowed_params)
        
        render json: { message: 'Pagamento confirmado com sucesso' }.to_json,
                      status: :ok
      end

      private

      def allowed_params
        {
          customer: Customer.find_by(token: params[:customer]),
          plan: Plan.find(params[:plan])
        }
      end
    end
  end
end