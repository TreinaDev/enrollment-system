require 'rails_helper'

describe 'Generate_token' do
  it 'success' do
    # Arrange
    data = {
      email: 'teste@teste.com',
      name: 'User',
      cpf: '1234',
      birthdate: '18/03/2000',
      payment_method: 1
    }

    allow(Customer).to receive(:generate_token).and_return('245')
    post '/api/v1/customers', params: data

    json_response = JSON.parse(response.body, symbolize_names: true)

    # Assert
    expect(Customer).to have_received(:generate_token)
    expect(response).to have_http_status(200)
    expect(json_response[:token]).to eq('245')
  end

  it 'register an user' do
    # Arrange

    # Act
    data = {
      email: 'teste@teste.com',
      name: 'User',
      cpf: '1234',
      birthdate: '18/03/2000',
      payment_method: 1
    }

    post '/api/v1/customers', params: data

    # Assert
    customer = Customer.last
    expect(customer.email).to eq(data[:email])
    expect(customer.cpf).to eq(data[:cpf])
    expect(customer.name).to eq(data[:name])
    expect(customer.birthdate.strftime('%d/%m/%Y')).to eq(data[:birthdate])
    expect(customer.token).not_to eq(nil)
  end
end
