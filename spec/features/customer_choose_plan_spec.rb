require 'rails_helper'

feature 'Customer see all plans' do
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

feature 'Customer enroll a plan' do
  scenario 'see the form' do
    # Arrange
    create(:customer, token: '123')
    yoga = create(:class_category, name: 'Yoga')
    plan = create(:plan, name: 'PlanoFit', monthly_rate: 200, monthly_class_limit: 5)
    create(:class_category_plan, plan: plan, class_category: yoga)
    ccred = PaymentMethod.new(name: 'Cartão de Crédito', code: 'CCRED')
    allow(PaymentMethod).to receive(:all).and_return([ccred])

    # Act
    visit new_enrollment_path(token: '123')

    # Assert
    expect(page).to have_content(plan.name)
    expect(page).to have_content(ccred.name)
  end

  scenario 'fill the form' do
    # Arrange
    customer = create(:customer, token: '123')
    yoga = create(:class_category, name: 'Yoga')
    plan = create(:plan, name: 'PlanoFit', monthly_rate: 200, monthly_class_limit: 5)
    create(:class_category_plan, plan: plan, class_category: yoga)
    ccred = PaymentMethod.new(name: 'Cartão de Crédito', code: 'CCRED')
    allow(PaymentMethod).to receive(:all).and_return([ccred])

    response = double('faraday_post', status: 200)
    data = {
      customer: customer.token,
      monthly_rate: plan.monthly_rate,
      payment_method: ccred.code
    }
    allow(Faraday).to receive(:post).with('http://localhost:5000/api/v1/approve_payment',
                                          params: data).and_return(response)

    # Act
    visit new_enrollment_path(token: '123')
    choose plan.name
    choose ccred.name
    click_on 'Comprar Plano'

    # Assert
    expect(current_path).to eq(root_path)
  end

  scenario 'fields are required' do
    # Arrange
    create(:customer, token: '123')
    yoga = create(:class_category, name: 'Yoga')
    plan = create(:plan, name: 'PlanoFit', monthly_rate: 200, monthly_class_limit: 5)
    create(:class_category_plan, plan: plan, class_category: yoga)
    ccred = PaymentMethod.new(name: 'Cartão de Crédito', code: 'CCRED')
    allow(PaymentMethod).to receive(:all).and_return([ccred])

    # Act
    visit new_enrollment_path(token: '123')
    click_on 'Comprar Plano'

    # Assert
    expect(page).to have_content(plan.name)
    expect(page).to have_content(ccred.name)
    expect(page).to have_text 'Plano é obrigatório'
    expect(page).to have_text 'Método de pagamento não pode ficar em branco'
  end

  context 'enrollment is sent to payment api' do
    scenario 'success' do
      # Arrange
      customer = create(:customer, token: '123')
      yoga = create(:class_category, name: 'Yoga')
      plan = create(:plan, name: 'PlanoFit', monthly_rate: 200, monthly_class_limit: 5)
      create(:class_category_plan, plan: plan, class_category: yoga)
      ccred = PaymentMethod.new(name: 'Cartão de Crédito', code: 'CCRED')
      allow(PaymentMethod).to receive(:all).and_return([ccred])

      response = double('faraday_post', status: 200)
      data = {
        customer: customer.token,
        monthly_rate: plan.monthly_rate,
        payment_method: ccred.code
      }
      allow(Faraday).to receive(:post).with('http://localhost:5000/api/v1/approve_payment',
                                            params: data).and_return(response)

      # Act
      visit new_enrollment_path(token: '123')
      choose plan.name
      choose ccred.name
      click_on 'Comprar Plano'

      # Assert
      enrollment = Enrollment.last
      expect(enrollment.status).to eq('active')
    end

    scenario 'pending if payment api fails' do
      # Arrange
      customer = create(:customer, token: '123')
      yoga = create(:class_category, name: 'Yoga')
      plan = create(:plan, name: 'PlanoFit', monthly_rate: 200, monthly_class_limit: 5)
      create(:class_category_plan, plan: plan, class_category: yoga)
      ccred = PaymentMethod.new(name: 'Cartão de Crédito', code: 'CCRED')
      allow(PaymentMethod).to receive(:all).and_return([ccred])

      response = double('faraday_post', status: 404)
      data = {
        customer: customer.token,
        monthly_rate: plan.monthly_rate,
        payment_method: ccred.code
      }
      allow(Faraday).to receive(:post).with('http://localhost:5000/api/v1/approve_payment',
                                            params: data).and_return(response)

      # Act
      visit new_enrollment_path(token: '123')
      choose plan.name
      choose ccred.name
      click_on 'Comprar Plano'

      # Assert
      enrollment = Enrollment.last
      expect(enrollment.status).to eq('pending')
    end
  end
end
