require 'rails_helper'

describe 'Get plans' do
  it 'success' do
    yoga = create(:class_category, name: 'Yoga', description: 'Balanço e flexibilidade')
    crossfit = create(:class_category, name: 'Crossfit')
    plan = create(:plan, name: 'Fit', description: 'Ideal para quem está começando', monthly_rate: 9.99,
                         monthly_class_limit: 10, class_categories: [yoga, crossfit])
    plan_basic = create(:plan, class_categories: [yoga])

    get '/api/v1/plans'

    categories = [{ id: yoga.id, name: yoga.name },
                  { id: crossfit.id, name: crossfit.name }]

    categories_basic = [{ id: yoga.id, name: yoga.name }]

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(200)
    expect(json_response.first[:name]).to eq plan.name
    expect(json_response.first[:description]).to eq plan.description
    expect(json_response.first[:monthly_class_limit]).to eq plan.monthly_class_limit
    expect(json_response.first[:monthly_rate]).to eq '9.99'
    expect(json_response.first[:class_categories]).to eq categories

    expect(json_response.last[:name]).to eq plan_basic.name
    expect(json_response.last[:description]).to eq plan_basic.description
    expect(json_response.last[:monthly_class_limit]).to eq plan_basic.monthly_class_limit
    expect(json_response.last[:monthly_rate]).to eq '100.0'
    expect(json_response.last[:class_categories]).to eq categories_basic
  end

  it 'should return error if plans is empty' do
    get '/api/v1/plans'
    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(404)
    expect(json_response[:msg]).to eq 'Não existem planos'
  end

  it 'should return plan of the respective token' do
    customer = create(:customer, token: '123')
    yoga = create(:class_category, name: 'Yoga', description: 'Balanço e flexibilidade')
    crossfit = create(:class_category, name: 'Crossfit')
    plan_fit = create(:plan, name: 'Fit', description: 'Ideal para quem está começando', monthly_rate: 9.99,
                             monthly_class_limit: 10, class_categories: [yoga, crossfit])
    create(:enrollment, customer: customer, plan: plan_fit)

    create(:plan, class_categories: [yoga])

    categories = [{ id: yoga.id, name: yoga.name },
                  { id: crossfit.id, name: crossfit.name }]

    get '/api/v1/enrollments/123'
    json_response = JSON.parse(response.body, symbolize_names: true)
    # byebug
    expect(response).to have_http_status(200)
    expect(json_response[:plan][:name]).to eq plan_fit.name
    expect(json_response[:plan][:description]).to eq plan_fit.description
    expect(json_response[:plan][:monthly_class_limit]).to eq plan_fit.monthly_class_limit
    expect(json_response[:plan][:monthly_rate]).to eq '9.99'
    expect(json_response[:plan][:class_categories]).to eq categories
  end

  it 'should return error if plan of the respective token dont exist' do
    customer = create(:customer, token: '123')
    yoga = create(:class_category, name: 'Yoga', description: 'Balanço e flexibilidade')
    crossfit = create(:class_category, name: 'Crossfit')
    plan_fit = create(:plan, name: 'Fit', description: 'Ideal para quem está começando', monthly_rate: 9.99,
                             monthly_class_limit: 10, class_categories: [yoga, crossfit])
    enrollment = create(:enrollment, customer: customer, plan: plan_fit, status: 10)

    get '/api/v1/enrollments/123'
    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(406)
    expect(json_response[:msg]).to eq 'Aluno não tem um plano vinculado'
    expect(enrollment.status).to eq 'inactive'
  end

  it 'should return error if token does not exist' do
    get '/api/v1/enrollments/123'
    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(404)
    expect(json_response[:msg]).to eq 'Token não encontrado'
  end
end
