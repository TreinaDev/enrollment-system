require 'rails_helper'

feature 'Admin cancel enrollments' do
  scenario 'can cancel' do
    # Arrange
    ccred = PaymentMethod.new(name: 'Cartão de Crédito', code: 'CCRED')
    allow(PaymentMethod).to receive(:all).and_return([ccred])
    plan = create(:plan, name: 'Basico')
    customer = create(:customer, name: 'Maria')
    enrollment = create(:enrollment, plan: plan, customer: customer, payment_method: ccred, status: 'active')
    admin = create(:user)

    # Act
    login_as admin, scope: :user
    visit root_path
    click_on 'Ver Matrículas'
    within("tr#enrollment_#{enrollment.id}") do
      click_on 'Cancelar'
    end

    # Assert
    expect(current_path).to eq(enrollments_path)
    within("tr#enrollment_#{enrollment.id}") do
      expect(page).to have_content('Inativo')
      expect(page).not_to have_content('Activo')
      expect(page).not_to have_link('Cancelar')
    end
  end

  context 'only to not inactive enrollments' do
    scenario 'inactive' do
      # Arrange
      ccred = PaymentMethod.new(name: 'Cartão de Crédito', code: 'CCRED')
      allow(PaymentMethod).to receive(:all).and_return([ccred])
      plan = create(:plan, name: 'Basico')
      customer = create(:customer, name: 'Maria')
      enrollment = create(:enrollment, plan: plan, customer: customer, payment_method: ccred, status: 'inactive')
      admin = create(:user)
  
      # Act
      login_as admin, scope: :user
      visit root_path
      click_on 'Ver Matrículas'
  
      # Assert
      within("tr#enrollment_#{enrollment.id}") do
        expect(page).not_to have_link('Cancelar')
      end
    end

    scenario 'pending' do
      # Arrange
      ccred = PaymentMethod.new(name: 'Cartão de Crédito', code: 'CCRED')
      allow(PaymentMethod).to receive(:all).and_return([ccred])
      plan = create(:plan, name: 'Basico')
      customer = create(:customer, name: 'Maria')
      enrollment = create(:enrollment, plan: plan, customer: customer, payment_method: ccred, status: 'pending')
      admin = create(:user)
  
      # Act
      login_as admin, scope: :user
      visit root_path
      click_on 'Ver Matrículas'
  
      # Assert
      within("tr#enrollment_#{enrollment.id}") do
        expect(page).not_to have_link('Cancelar')
      end
    end
  end
end