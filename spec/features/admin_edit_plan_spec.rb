require 'rails_helper'

feature 'Admin edit a plan' do
  scenario 'successfully' do
    allow(PaymentMethod).to receive(:all).and_return([])
    yoga = create(:class_category, name: 'Yoga', description: 'Balanço e flexibilidade')
    create(:class_category, name: 'Crossfit')
    plan = create(:plan, name: 'Basico', monthly_rate: '100', monthly_class_limit: 10,
                         description: 'Ideal para iniciantes', class_categories: [yoga])
    admin = create(:user)
    login_as admin, scope: :user
    visit root_path
    click_on plan.name
    click_on 'Editar Plano'
    fill_in 'Nome', with: 'Fit'
    fill_in 'Descrição', with: 'Ideal para quem está começando'
    fill_in 'Mensalidade', with: '9.99'
    fill_in 'Quantidade de aulas por mês', with: '20'
    check 'Crossfit'
    uncheck 'Yoga'
    click_on 'Editar Plano'

    expect(current_path).to eq plan_path(plan)
    expect(page).to have_content('Nome: Fit')
    expect(page).to have_content('Descrição: Ideal para quem está começando')
    expect(page).to have_content('Mensalidade: R$ 9,99')
    expect(page).to have_content('Quantidade de aulas por mês: 20')
    expect(page).to have_content('Categorias de aulas: Crossfit')
  end

  scenario 'and cannot be blank' do
    allow(PaymentMethod).to receive(:all).and_return([])
    yoga = create(:class_category, name: 'Yoga')
    plan = create(:plan, name: 'Basico', monthly_rate: '100', monthly_class_limit: 10,
                         description: 'Ideal para iniciantes', class_categories: [yoga])
    admin = create(:user)
    login_as admin, scope: :user
    visit root_path
    click_on plan.name
    click_on 'Editar Plano'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Mensalidade', with: ''
    fill_in 'Quantidade de aulas por mês', with: ''
    uncheck 'Yoga'
    click_on 'Editar Plano'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Mensalidade não pode ficar em branco')
    expect(page).to have_content('Quantidade de aulas por mês não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
  end

  scenario 'and name must be unique' do
    allow(PaymentMethod).to receive(:all).and_return([])
    yoga = create(:class_category, name: 'Yoga')
    basic_plan = create(:plan, name: 'Basico', monthly_rate: '100', monthly_class_limit: 10,
                               description: 'Ideal para iniciantes', class_categories: [yoga])
    create(:plan, name: 'Fit', monthly_rate: '9.99', monthly_class_limit: 20,
                  description: 'Ideal para iniciantes', class_categories: [yoga])
    admin = create(:user)
    login_as admin, scope: :user
    visit root_path

    click_on basic_plan.name
    click_on 'Editar Plano'
    fill_in 'Nome', with: 'Fit'
    click_on 'Editar Plano'

    expect(page).to have_content('Nome já está em uso')
  end

  scenario 'and monthly_rate and monthly_class_limit must be greater than 0' do
    allow(PaymentMethod).to receive(:all).and_return([])
    yoga = create(:class_category, name: 'Yoga')
    basic_plan = create(:plan, name: 'Basico', monthly_rate: '100', monthly_class_limit: 10,
                               description: 'Ideal para iniciantes', class_categories: [yoga])

    admin = create(:user)
    login_as admin, scope: :user
    visit root_path

    click_on basic_plan.name
    click_on 'Editar Plano'
    fill_in 'Mensalidade', with: 0
    fill_in 'Quantidade de aulas por mês', with: 0
    click_on 'Editar Plano'

    expect(page).to have_content('Mensalidade deve ser maior que 0')
    expect(page).to have_content('Quantidade de aulas por mês deve ser maior que 0')
  end

  scenario 'and monthly_rate and monthly_class_limit must be greater than 0' do
    allow(PaymentMethod).to receive(:all).and_return([])
    yoga = create(:class_category, name: 'Yoga')
    basic_plan = create(:plan, name: 'Basico', monthly_rate: '100', monthly_class_limit: 10,
                               description: 'Ideal para iniciantes', class_categories: [yoga])

    admin = create(:user)
    login_as admin, scope: :user
    visit root_path

    click_on basic_plan.name
    click_on 'Editar Plano'
    fill_in 'Mensalidade', with: 'zero'
    fill_in 'Quantidade de aulas por mês', with: 'dois'
    click_on 'Editar Plano'

    expect(page).to have_content('Mensalidade não é um número')
    expect(page).to have_content('Quantidade de aulas por mês não é um número')
  end
end
