require 'rails_helper'

describe 'Get enrollment status' do
  it 'inactive' do
    # Arrange
    customer = create(:customer, token: '123')
    yoga = create(:class_category, name: 'Yoga')
    plan = create(:plan, name: 'PlanoFit', monthly_rate: 200, monthly_class_limit: 5)
    create(:class_category_plan, plan: plan, class_category: yoga)
    ccred = PaymentMethod.new(name: 'Cartão de Crédito', code: 'CCRED')
    allow(PaymentMethod).to receive(:all).and_return([ccred])
    Enrollment.create!(customer: customer, plan: plan, payment_method: ccred)

    # Act
    get "/api/v1/customers/status?token=#{customer.token}"

    # Assert
    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(response).to have_http_status(200)
    expect(json_response[:token]).to eq('123')
    expect(json_response[:plan][:id]).to eq(plan.id)
    expect(json_response[:status]).to eq('inactive')
  end

  it 'active' do
    # Arrange
    customer = create(:customer, token: '123')
    yoga = create(:class_category, name: 'Yoga')
    plan = create(:plan, name: 'PlanoFit', monthly_rate: 200, monthly_class_limit: 5)
    create(:class_category_plan, plan: plan, class_category: yoga)
    ccred = PaymentMethod.new(name: 'Cartão de Crédito', code: 'CCRED')
    allow(PaymentMethod).to receive(:all).and_return([ccred])
    Enrollment.create!(customer: customer, plan: plan, payment_method: ccred, status: :active)

    # Act
    get "/api/v1/customers/status?token=#{customer.token}"

    # Assert
    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(response).to have_http_status(200)
    expect(json_response[:token]).to eq('123')
    expect(json_response[:plan][:id]).to eq(plan.id)
    expect(json_response[:status]).to eq('active')
  end

  it 'pending' do
    # Arrange
    customer = create(:customer, token: '123')
    yoga = create(:class_category, name: 'Yoga')
    plan = create(:plan, name: 'PlanoFit', monthly_rate: 200, monthly_class_limit: 5)
    create(:class_category_plan, plan: plan, class_category: yoga)
    ccred = PaymentMethod.new(name: 'Cartão de Crédito', code: 'CCRED')
    allow(PaymentMethod).to receive(:all).and_return([ccred])
    Enrollment.create!(customer: customer, plan: plan, payment_method: ccred, status: :pending)

    # Act
    get "/api/v1/customers/status?token=#{customer.token}"

    # Assert
    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(response).to have_http_status(200)
    expect(json_response[:token]).to eq('123')
    expect(json_response[:plan][:id]).to eq(plan.id)
    expect(json_response[:status]).to eq('pending')
  end

  it 'token not found' do
    # Arrange

    # Act
    get '/api/v1/customers/status?token=456'

    # Assert
    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(response).to have_http_status(404)
    expect(json_response[:message]).to eq('Token não encontrado')
  end
end
