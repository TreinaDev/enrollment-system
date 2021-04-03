require 'rails_helper'

feature 'Admin create class category' do
  scenario 'sucessfully' do
    user = create(:user)
    allow(PaymentMethod).to receive(:all).and_return([])
    renato = ResponsibleTeacher.new(name: 'Renato Teixeira')
    izabela = ResponsibleTeacher.new(name: 'Izabela Marcondes')
    lucas = ResponsibleTeacher.new(name: 'Lucas Praça')
    allow(ResponsibleTeacher).to receive(:all).and_return([renato, izabela, lucas])

    login_as user, scope: :user
    visit root_path
    click_on 'Cadastrar Categoria de Aulas'
    fill_in 'Nome', with: 'Yoga'
    fill_in 'Descrição', with: 'Aulas para desestressar'
    select 'Renato Teixeira', from: 'Professor Responsável'
    find('form input[type="file"]').set(Rails.root.join('spec/support/yoga_icon.jpg'))
    click_on 'Cadastrar nova Categoria de Aula'

    expect(current_path).to eq class_category_path(ClassCategory.last)
    expect(page).to have_css('img[src*="yoga_icon.jpg"]')
    expect(page).to have_content('Yoga')
    expect(page).to have_content('Aulas para desestressar')
    expect(page).to have_content('Renato Teixeira')
    expect(page).to have_content('Editar Categoria de Aula')
    expect(page).to have_content('Excluir Categoria de Aula')
  end

  scenario 'and cannot leave fields blank' do
    user = create(:user)
    allow(PaymentMethod).to receive(:all).and_return([])
    allow(ResponsibleTeacher).to receive(:all).and_return([])

    login_as user, scope: :user
    visit root_path
    click_on 'Cadastrar Categoria de Aulas'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    find('form input[type="file"]').set(Rails.root.join('spec/support/yoga_icon.jpg'))
    click_on 'Cadastrar nova Categoria de Aula'

    expect(page).to have_content('Ocorreram erros durante o cadastro, veja abaixo:')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Professor Responsável não pode ficar em branco')
  end

  scenario 'and atributes must be unique' do
    user = create(:user)
    allow(PaymentMethod).to receive(:all).and_return([])
    renato = ResponsibleTeacher.new(name: 'Renato Teixeira')
    allow(ResponsibleTeacher).to receive(:all).and_return([renato])
    create(:class_category, name: 'Yoga', description: 'Aulas para desestressar')

    login_as user, scope: :user
    visit root_path
    click_on 'Cadastrar Categoria de Aulas'
    fill_in 'Nome', with: 'Yoga'
    fill_in 'Descrição', with: 'Aulas para desestressar'
    find('form input[type="file"]').set(Rails.root.join('spec/support/yoga_icon.jpg'))
    click_on 'Cadastrar nova Categoria de Aula'

    expect(page).to have_content('Ocorreram erros durante o cadastro, veja abaixo:')
    expect(page).to have_content('Nome já está em uso')
    expect(page).to have_content('Descrição já está em uso')
  end

  scenario 'and cannot create if classroom API is down' do
    user = create(:user)
    allow(PaymentMethod).to receive(:all).and_return([])
    allow(ResponsibleTeacher).to receive(:all).and_return([])

    login_as user, scope: :user
    visit root_path
    click_on 'Cadastrar Categoria de Aulas'
    fill_in 'Nome', with: 'Yoga'
    fill_in 'Descrição', with: 'Aulas para desestressar'
    find('form input[type="file"]').set(Rails.root.join('spec/support/yoga_icon.jpg'))

    expect(page).not_to have_content('Cadastrar nova Categoria de Aula')
    expect(page).to have_content('Não podemos cadastrar esta categoria no momento')
  end
end
