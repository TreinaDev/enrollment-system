require 'rails_helper'

describe 'Generate_token' do 

    it 'has a route to receive a post' do 
        # Arrange
        
        # Act
        data = {
            :email => 'teste@teste.com'
        }

        post '/api/v1/customers', params: data
        json_response = JSON.parse(response.body, symbolize_names: true)

        # Assert
        expect(json_response[:test]).to eq('funcionou')
    end

end