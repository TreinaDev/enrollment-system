module Api
  module V1
    class CustomersController < ApiController
      def create
        customer = Customer.create(allowed_params)
        if customer.valid?
          customer.save
          render json: { token: customer.token }.to_json, status: :created
        else
          errors = customer.errors.to_hash
          render json: { message: errors }.to_json, status: :bad_request
        end
      end

      def show
        customer = Customer.find_by(cpf: params[:id])
        if customer.nil?
          render json: { message: 'Token não encontrado' }.to_json,
                 status: :not_found
        else
          render json: { token: customer.token }.to_json, status: :ok
        end
      end

      private

      def allowed_params
        {
          name: params[:name],
          cpf: params[:cpf],
          birthdate: params[:birthdate],
          email: params[:email],
          token: Customer.generate_token
        }
      end
    end
  end
end
