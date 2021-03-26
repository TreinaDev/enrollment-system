require 'rails_helper'

feature 'Visitor views plan details' do
  scenario 'successfully' do
    allow(PaymentMethod).to receive(:all).and_return([])
    yoga = create(:class_category, name: 'Yoga')
    crossfit = create(:class_category, name: 'Crossfit')
    plan = create(:plan, name: 'Fit', description: 'Ideal para quem está começando', monthly_rate: 9.99,
                         monthly_class_limit: 10, class_categories: [crossfit, yoga])

    visit root_path
    click_on plan.name

    expect(current_path).to eq plan_path(plan)
    expect(page).to have_text 'Nome: Fit'
    expect(page).to have_text 'Descrição: Ideal para quem está começando'
    expect(page).to have_text 'Mensalidade: 9.99'
    expect(page).to have_text 'Quantidade de aulas por mês: 10'
    expect(page).to have_text 'Categorias de aulas: Crossfit, Yoga'
    expect(page).to have_button 'Comprar plano'
  end

  scenario 'and clicks to hire a plan' do
    allow(PaymentMethod).to receive(:all).and_return([])

    plan = create(:plan)

    visit root_path
    click_on plan.name
    click_on 'Comprar plano'

    expect(current_path).to eq
  end
end
