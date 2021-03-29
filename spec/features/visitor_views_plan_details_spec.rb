require 'rails_helper'

feature 'Visitor views plan details' do
  scenario 'successfully' do
    allow(PaymentMethod).to receive(:all).and_return([])
    yoga = create(:class_category, name: 'Yoga', description: 'Balanço e flexibilidade')
    crossfit = create(:class_category, name: 'Crossfit')
    plan = create(:plan, name: 'Fit', description: 'Ideal para quem está começando', monthly_rate: 9.99,
                         monthly_class_limit: 10, class_categories: [crossfit, yoga])

    user = create(:user, role: :user)
    login_as user, scope: :user
    visit root_path
    click_on plan.name

    expect(current_path).to eq plan_path(plan)
    expect(page).to have_text 'Nome: Fit'
    expect(page).to have_text 'Descrição: Ideal para quem está começando'
    expect(page).to have_text 'Mensalidade: 9.99'
    expect(page).to have_text 'Quantidade de aulas por mês: 10'
    expect(page).to have_text 'Categorias de aulas: Crossfit, Yoga'
    expect(page).to have_link 'Comprar plano'
  end

  scenario 'and clicks to hire a plan' do
    yoga = create(:class_category, name: 'Yoga', description: 'Balanço e flexibilidade')
    crossfit = create(:class_category, name: 'Crossfit')
    create(:plan, name: 'Fit', description: 'Ideal para quem está começando', monthly_rate: 9.99,
                  monthly_class_limit: 10, class_categories: [crossfit, yoga])
    customer = create(:customer)

    resp_json = '{ "blocked": false }'
    resp_double = double('faraday_response', status: :ok, body: resp_json)
    allow(Faraday).to receive(:get).with("API/#{customer.cpf}")
                                   .and_return(resp_double)
    allow(PaymentMethod).to receive(:all).and_return([])
    allow_any_instance_of(ActionController::Redirecting).to receive(:redirect_to).and_return('')

    visit 'http://localhost/plans/1/?token=123'
    click_on 'Comprar plano'

    expect(Enrollment.count).to eq 1
  end
end
