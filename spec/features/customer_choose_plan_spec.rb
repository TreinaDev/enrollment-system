require 'rails_helper'

feature 'Customer choose a plan' do
  scenario 'successfully' do
    yoga = ClassCategory.create!(name: 'Yoga')
    first_plan = Plan.create!(name: 'PlanoFit', montlhy_rate: 200, monthly_class_limit: 5)
    second_plan = Plan.create!(name: 'PlanoSmart', montlhy_rate: 300, monthly_class_limit: 7)
    class_category_plan = ClassCategoryPlan.create!(plan: first_plan, class_category: yoga)
    ccred = PaymentMethod.new(name: 'Cartão de Crédito', code: 'CCRED')
    bol = PaymentMethod.new(name: 'Boleto', code: 'BOL')
    payment_methods = [ccred, bol]
    allow(PaymentMethod).to receive(:all).and_return(payment_methods)

    visit root_path
    
    within("div#plan-#{first_plan.id}") do
      expect(page).to have_content(first_plan.name)
      expect(page).to have_content(first_plan.montlhy_rate)
      expect(page).to have_content(first_plan.monthly_class_limit)
      expect(page).to have_content('Yoga')
    end
    within("div#plan-#{second_plan.id}") do
      expect(page).to have_content(second_plan.name)
      expect(page).to have_content(second_plan.montlhy_rate)
      expect(page).to have_content(second_plan.monthly_class_limit)
    end
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
    yoga = ClassCategory.create!(name: 'Yoga')
    plan = Plan.create!(name: 'PlanoFit', montlhy_rate: 200, monthly_class_limit: 5)
    class_category_plan = ClassCategoryPlan.create!(plan: plan, class_category: yoga)
    payment_methods = []
    allow(PaymentMethod).to receive(:all).and_return(payment_methods)

    visit root_path
    
    within("div#plan-#{plan.id}") do
      expect(page).to have_content(plan.name)
      expect(page).to have_content(plan.montlhy_rate)
      expect(page).to have_content(plan.monthly_class_limit)
      expect(page).to have_content('Yoga')
    end
    expect(page).to have_content('Não é possível contratar planos agora')
  end
end
