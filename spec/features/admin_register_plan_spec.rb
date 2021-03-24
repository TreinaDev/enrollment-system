require 'rails_helper'

feature 'Admin register a plan' do
  scenario 'successfully' do
    crossfit = create(:class_category, name: 'Crossfit')
    yoga = create(:class_category, name: 'Yoga')
    allow(PaymentMethod).to receive(:all).and_return([])

    visit root_path
    click_on 'Cadastrar Plano'
    fill_in 'Nome', with: 'Fit'
    fill_in 'Descrição', with: 'Ideal para quem está começando'
    fill_in 'Mensalidade', with: '9.99'
    fill_in 'Quantidade de aulas por mês', with: '10'
    check 'Crossfit'
    check 'Yoga'
    click_on 'Cadastrar Plano'

    plan = Plan.last
    expect(current_path).to eq plan_path(plan)
    expect(plan.monthly_rate).to eq 9.99
    expect(plan.monthly_class_limit).to eq 10
    expect(plan.name).to eq 'Fit'
    expect(plan.description).to eq 'Ideal para quem está começando'
    expect(plan.class_categories).to include yoga, crossfit
  end

  scenario 'and fields cannot be empty' do
    admin = create(:user)
    login_as admin, scope: :user
    visit root_path
    click_on 'Cadastrar Plano'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Mensalidade', with: ''
    fill_in 'Limite de Aulas', with: ''
    click_on 'Cadastrar plano'

    expect(Plan.errors.count).to eq 5
    expect(ClassCategoryPlan.count).to eq 0
  end

  #scenario 'and name must be unique' do
  #end
end
