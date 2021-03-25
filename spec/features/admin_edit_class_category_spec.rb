require 'rails_helper'

feature 'Admin edit class category' do
  scenario 'Successfully' do
    # Arrange
    allow(PaymentMethod).to receive(:all).and_return([])
    user = User.create!(email: 'renata@smartflix.com.br', password: '123456', 
                        role: :admin)
    class_category = ClassCategory.create!(name: 'Crossfit', 
                                           description: 'Fica grande', 
                                           responsible_teacher: 'Felipe Franco')
    renato = ResponsibleTeacher.new(name: 'Renato Teixeira')
    izabela = ResponsibleTeacher.new(name: 'Izabela Marcondes')
    lucas = ResponsibleTeacher.new(name: 'Lucas Praça')
    allow(ResponsibleTeacher).to receive(:all).and_return([renato, izabela, lucas])

    # Act
    login_as user, scope: :user
    visit root_path
    click_on 'Categorias de Aula'
    click_on 'Crossfit'
    click_on 'Editar Categoria de Aula'
    fill_in 'Descrição', with: 'Condicionamento físico completo'
    select 'Lucas Praça', from: 'Professor Responsável'
    find('form input[type="file"]').set(Rails.root.join('spec','support', 
                                                        'crossfit_icon.jpg'))
    click_on 'Editar Categoria de Aula'

    # Assert
    expect(page).to have_content('Categoria de Aula editada com sucesso.')
    expect(page).to have_content('Crossfit')
    expect(page).to have_content('Lucas Praça')
    expect(page).to have_content('Condicionamento físico completo')
    expect(page).to have_css('img[src*="crossfit_icon.jpg"]')
    expect(page).not_to have_content('Renato Teixeira')
  end

  scenario 'and atrributes cannot be blank' do

    allow(PaymentMethod).to receive(:all).and_return([])
    user = User.create!(email: 'renata@smartflix.com.br', password: '123456', 
                        role: :admin)
    class_category = ClassCategory.create!(name: 'Crossfit', 
                                           description: 'Fica grande', 
                                           responsible_teacher: 'Felipe Franco')
    renato = ResponsibleTeacher.new(name: 'Renato Teixeira')
    izabela = ResponsibleTeacher.new(name: 'Izabela Marcondes')
    lucas = ResponsibleTeacher.new(name: 'Lucas Praça')
    allow(ResponsibleTeacher).to receive(:all).and_return([renato, izabela, lucas])

    login_as user, scope: :user
    visit root_path
    click_on 'Categorias de Aula'
    click_on 'Crossfit'
    click_on 'Editar Categoria de Aula'
    fill_in 'Descrição', with: ''
    click_on 'Editar Categoria de Aula'

    expect(page).to have_content('Ocorreram erros durante a edição, veja abaixo:')
    expect(page).to have_content('Descrição não pode ficar em branco')
  end

  scenario 'and only admin can edit class categories' do
    allow(PaymentMethod).to receive(:all).and_return([])
    user = User.create!(email: 'renato@flix.com.br', password: '123456')
    login_as user, scope: :user
    visit root_path

    expect(page).not_to have_link('Categorias de Aulas')
  end
end