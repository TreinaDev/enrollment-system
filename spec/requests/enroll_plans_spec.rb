require 'rails_helper'

describe 'Enroll Plans' do
  it 'success' do
    # Arrange
    customer = create(:customer)
    plan = create(:plan)
    enrollment = Enrollment.create!(customer: customer, plan: plan)
    
    # Act
    data = {
      customer: customer.token,
      payment_method: customer.payment_method,
      plan: plan.id,
      price: plan.monthly_rate
    }
    post '/api/v1/enrollments', params: data
    
    # Assert
    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(response).to have_http_status(200)
    expect(json_response[:message]).to eq('Pagamento confirmado com sucesso')
  end
end
