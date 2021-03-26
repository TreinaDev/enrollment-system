require 'rails_helper'

feature 'Admin register a plan' do
  scenario 'successfully' do
    crossfit = create(:class_category, name: 'Crossfit')
    yoga = create(:class_category, name: 'Yoga')
    allow(PaymentMethod).to receive(:all).and_return([])

    admin = create(:user)
    login_as admin, scope: :user
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

  scenario 'and views plan details' do
    crossfit = create(:class_category, name: 'Crossfit')
    yoga = create(:class_category, name: 'Yoga')
    allow(PaymentMethod).to receive(:all).and_return([])
    plan = Plan.create(name: 'Fit',
                       description: 'Ideal para quem está começando',
                       monthly_rate: 9.99,
                       monthly_class_limit: 10,
                       class_categories: [crossfit, yoga])
    visit root_path
    click_on 'Fit'

    expect(current_path).to eq plan_path(plan)
    expect(page).to have_text 'Nome: Fit'
    expect(page).to have_text 'Descrição: Ideal para quem está começando'
    expect(page).to have_text 'Mensalidade: 9.99'
    expect(page).to have_text 'Quantidade de aulas por mês: 10'
    expect(page).to have_text 'Categorias de aulas: Crossfit, Yoga'
  end

  scenario 'and fields cannot be empty' do
    allow(PaymentMethod).to receive(:all).and_return([])

    admin = create(:user)
    login_as admin, scope: :user
    visit root_path
    click_on 'Cadastrar Plano'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Mensalidade', with: ''
    fill_in 'Quantidade de aulas por mês', with: ''
    click_on 'Cadastrar Plano'

    expect(Plan.count).to eq 0
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Mensalidade não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Quantidade de aulas por mês não pode ficar em branco')
  end
end
