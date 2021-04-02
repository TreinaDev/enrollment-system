feature 'Customer views account details' do
  scenario 'successfully' do
    ccred = PaymentMethod.new(name: 'Cartão de Crédito', code: 'CCRED')
    allow(PaymentMethod).to receive(:all).and_return([ccred])
    customer = create(:customer, name: 'Maria', token: '123')
    enrollment = create(:enrollment, status: 'active', customer: customer)

    login_as customer, scope: :customer
    visit root_path(token: customer.token)
    click_on 'Ver Matrícula'

    expect(current_path).to eq enrollment_path(enrollment)
    expect(page).to have_content 'Maria'
    expect(page).to have_content 'Basico'
    expect(page).to have_button 'Cancelar matrícula'
  end
end
