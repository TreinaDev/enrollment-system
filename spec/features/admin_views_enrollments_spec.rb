require 'rails_helper'

feature 'Admin views enrollments' do
  scenario 'success' do
    # Arrange
    ccred = PaymentMethod.new(name: 'Cartão de Crédito', code: 'CCRED')
    allow(PaymentMethod).to receive(:all).and_return([ccred])
    plan = create(:plan, name: 'Basico')
    customer = create(:customer, name: 'Maria')
    create(:enrollment, plan: plan, customer: customer, payment_method: ccred, status: 'inactive')
    admin = create(:user)

    # Act
    login_as admin, scope: :user
    visit root_path
    click_on 'Ver Matrículas'

    # Assert
    expect(current_path).to eq(enrollments_path)
    expect(page).to have_content('Maria')
    expect(page).to have_content('Inativo')
    expect(page).to have_content('Basico')
  end

  scenario 'return message if empty' do
    # Arrange
    ccred = PaymentMethod.new(name: 'Cartão de Crédito', code: 'CCRED')
    allow(PaymentMethod).to receive(:all).and_return([ccred])
    admin = create(:user)

    # Act
    login_as admin, scope: :user
    visit root_path
    click_on 'Ver Matrículas'

    # Assert
    expect(current_path).to eq(enrollments_path)
    expect(page).to have_content('Nenhuma matrícula encontrada')
  end
end
