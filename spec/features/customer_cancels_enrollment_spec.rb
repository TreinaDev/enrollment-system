require 'rails_helper'

feature 'Customer cancels enrollment' do
  scenario 'successfully' do
    ccred = PaymentMethod.new(name: 'Cartão de Crédito', code: 'CCRED')
    allow(PaymentMethod).to receive(:all).and_return([ccred])
    customer = create(:customer, token: '123')
    enrollment = create(:enrollment, status: 'active', customer: customer)

    login_as customer, scope: :customer
    visit root_path(token: customer.token)
    click_on 'Ver Matrícula'
    click_on 'Cancelar matrícula'

    expect(Enrollment.count).to eq 1
    expect(Enrollment.first.status).to eq 'inactive'
    expect(page).to have_content 'Status da matrícula: Inativa'
  end
end