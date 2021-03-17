module Api 
    module V1
        class CustomersController < ApiController

            def create 
                return render json: {'test': 'funcionou'}.to_json
            end

        end
    end
end
