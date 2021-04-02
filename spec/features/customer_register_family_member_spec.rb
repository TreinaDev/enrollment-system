require 'rails_helper'

feature 'Customer register family member' do
  scenario 'succesfully' do
    allow(PaymentMethod).to receive(:all).and_return([])
    customer = create(:customer)
    plan = create(:plan, name: 'Familia', max_dependents: 4)
    enrollment = (:enrollment)

    visit root_path
    click_on 'Familia'
    click_on 'Cadastrar dependentes'
    fill_in 'E-mail', with: 'jeska@flix.com.br'
    click_on 'Cadastrar dependente'

    expect(page).to have_content('Dependente cadastrado com sucesso')
  end
end
