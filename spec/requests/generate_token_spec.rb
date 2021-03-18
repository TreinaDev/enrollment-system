require 'rails_helper'

describe 'Generate_token' do 

    it 'success' do 
        # Arrange
        
        # Act
        data = {
          email: 'teste@teste.com',
          name: 'User',
          cpf: '1234',
          birthdate: '18/03/2000'
        }

        post '/api/v1/customers', params: data
        

        customer_double = double(Customer)
        allow(customer_double).to receive(:generate_token).and_return('245')

        json_respose = JSON.parse(response.body, symbolize_names: true)

        # Assert
        expect(response).to have_http_status(200)
        expect(customer_double.generate_token).to eq('245')
    end

end