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

      def status
        customer = Customer.find_by(token: params[:token])
        if customer.nil?
          return render json: { message: 'Token não encontrado' }.to_json,
                        status: :not_found
        end
        plans_keys = %i[id name monthly_rate monthly_class_limit
                        description status]
        category_keys = %i[id name responsible_teacher]

        render json: status_json(customer, plans_keys, category_keys).to_json,
               status: :ok
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

      def status_json(customer, plans_keys, category_keys)
        {
          token: customer.token,
          plan: customer.enrollment.plan.slice(plans_keys),
          categories: customer.enrollment.plan.class_categories
                              .map { |item| item.slice(category_keys) },
          enrolled_at: customer.enrollment.updated_at.strftime('%d/%m/%Y'),
          status: customer.enrollment.status
        }
      end
    end
  end
end
