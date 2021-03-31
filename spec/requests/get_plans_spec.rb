require 'rails_helper'

describe 'Get plans' do
  it 'success' do
    yoga = create(:class_category, name: 'Yoga', description: 'Balanço e flexibilidade')
    crossfit = create(:class_category, name: 'Crossfit')
    plan = create(:plan, name: 'Fit', description: 'Ideal para quem está começando', monthly_rate: 9.99,
                         monthly_class_limit: 10, class_categories: [yoga, crossfit])
    plan_basic = create(:plan, class_categories: [yoga])

    get '/api/v1/plans'

    categories = [{id: yoga.id, name: yoga.name}, 
                  {id: crossfit.id, name: crossfit.name} ]

    categories_basic = [{id: yoga.id , name: yoga.name}]

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
end