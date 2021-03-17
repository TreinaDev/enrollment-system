require 'rails_helper'

feature 'Customer choose a plan' do
  scenario 'successfully' do
    yoga = ClassCategory.create!(name: 'Yoga')
    #payment_methods = Faraday.get('pagamentos.com/v1/api/todos')
    first_plan = Plan.create!(name: 'PlanoFit', montlhy_rate: 200, monthly_class_limit: 5, class_category_ids: [yoga.id])
    second_plan = Plan.create!(name: 'PlanoSmart', montlhy_rate: 300, monthly_class_limit: 7, class_category_ids: [yoga.id])

    json_response = JSON.parse({name: 'Boleto', code: 'BOL' },
                                {name: 'Cartão de Crédito', code: 'CCRED'})
    allow(Faraday).to receive(:get).with('pagamentos.com/v1/api/todos').and_return(json_response)

    visit root_path

    expect(page).to have_content(first_plan.name)
    expect(page).to have_content(first_plan.montlhy_rate)
    expect(page).to have_content(first_plan.monthly_class_limit)
    expect(page).to have_content('Yoga')
    expect(page).to have_content(second_plan.name)
    expect(page).to have_content(second_plan.montlhy_rate)
    expect(page).to have_content(second_plan.monthly_class_limit)
    expect(page).to have_content('Boleto')
    expect(page).to have_content('Cartão de Crédito')
  end

  scenario 'and show error if no plans are found' do
    visit root_path

    expect(page).to have_content('Não há planos cadastrados')
  end
end