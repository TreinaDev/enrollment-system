module Api 
    module V1
        class CustomersController < ApiController

            def create 
                token = Customer.generate_token
                customer = Customer.create!(
                    name: params[:name],
                    cpf: params[:cpf],
                    birthdate: params[:birthdate],
                    email: params[:email],
                    token: token
                )
                return render json: { 'token': token }.to_json, status: 200
            end

        end
    end
end
