require 'rails_helper'

feature 'Customer choose a plan' do
  scenario 'successfully' do
    yoga = create(:class_category, name: 'Yoga')
    first_plan = create(:plan, name: 'PlanoFit', monthly_rate: 200, monthly_class_limit: 5)
    second_plan = create(:plan, name: 'PlanoSmart', monthly_rate: 300, monthly_class_limit: 7)
    create(:class_category_plan, plan: first_plan, class_category: yoga)
    ccred = PaymentMethod.new(name: 'Cartão de Crédito', code: 'CCRED')
    bol = PaymentMethod.new(name: 'Boleto', code: 'BOL')
    allow(PaymentMethod).to receive(:all).and_return([ccred, bol])

    visit root_path

    within("div#plan-#{first_plan.id}") do
      expect(page).to have_content('Nome: ')
      expect(page).to have_content(first_plan.name)
      expect(page).to have_content('Mensalidade: ')
      expect(page).to have_content(first_plan.monthly_rate)
      expect(page).to have_content('Quantidade de aulas por mês: ')
      expect(page).to have_content(first_plan.monthly_class_limit)
      expect(page).to have_content('Aulas abrangidas:')
      expect(page).to have_content('Yoga')
    end
    within("div#plan-#{second_plan.id}") do
      expect(page).to have_content('Nome:')
      expect(page).to have_content(second_plan.name)
      expect(page).to have_content('Mensalidade:')
      expect(page).to have_content(second_plan.monthly_rate)
      expect(page).to have_content('Quantidade de aulas por mês:')
      expect(page).to have_content(second_plan.monthly_class_limit)
    end
    expect(page).to have_content('Meios de pagamentos:')
    expect(page).to have_content('Boleto')
    expect(page).to have_content('Cartão de Crédito')
  end

  scenario 'and show error if no plans are found' do
    payment_methods = []
    allow(PaymentMethod).to receive(:all).and_return(payment_methods)
    visit root_path

    expect(page).to have_content('Não há planos cadastrados')
  end

  scenario 'and show error if payment methods are down' do
    yoga = create(:class_category, name: 'Yoga')
    plan = create(:plan, name: 'PlanoFit', monthly_rate: 200, monthly_class_limit: 5)
    create(:class_category_plan, plan: plan, class_category: yoga)
    allow(PaymentMethod).to receive(:all).and_return([])

    visit root_path

    within("div#plan-#{plan.id}") do
      expect(page).to have_content('Nome: ')
      expect(page).to have_content(plan.name)
      expect(page).to have_content('Mensalidade: ')
      expect(page).to have_content(plan.monthly_rate)
      expect(page).to have_content('Quantidade de aulas por mês: ')
      expect(page).to have_content(plan.monthly_class_limit)
      expect(page).to have_content('Aulas abrangidas: ')
      expect(page).to have_content('Yoga')
    end
    expect(page).to have_content('Não é possível contratar planos agora')
  end
end
