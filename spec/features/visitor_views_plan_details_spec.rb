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
end
