require 'rails_helper'

feature 'Admin delete class category' do
  scenario 'succesfully' do
    # Arrange
    allow(PaymentMethod).to receive(:all).and_return([])
    user = User.create!(email: 'renata@smartflix.com.br', password: '123456',
                        role: :admin)
    ClassCategory.create!(name: 'Crossfit',
                          description: 'Fica grande',
                          responsible_teacher: 'Felipe Franco')
    ClassCategory.create!(name: 'Yoga',
                          description: 'Tranquilidade',
                          responsible_teacher: 'Mudra')

    # Act
    login_as user, scope: :user
    visit root_path
    click_on 'Categorias de Aula'
    click_on 'Crossfit'
    click_on 'Excluir Categoria de Aula'

    # Assert
    expect(current_path).to eq class_categories_path
    expect(page).to have_content('Categoria excluida com sucesso')
    expect(page).to have_content('Yoga')
    expect(page).not_to have_content('Crossfit')
  end
end
