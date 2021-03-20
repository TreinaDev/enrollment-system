require 'rails_helper'

feature 'Admin create class category' do
  scenario 'sucessfully' do
    allow(PaymentMethod).to receive(:all).and_return([])
    renato = ResponsibleTeacher.new(name: 'Renato Teixeira')
    izabela = ResponsibleTeacher.new(name: 'Izabela Marcondes')
    lucas = ResponsibleTeacher.new(name: 'Lucas Praça')
    allow(ResponsibleTeacher).to receive(:all).and_return([renato, izabela, lucas])

    visit root_path
    click_on 'Cadastrar Categoria de Aulas'
    fill_in 'Nome', with: 'Yoga'
    fill_in 'Descrição', with: 'Aulas para desestressar'
    select 'Renato Teixeira', from: 'Professor Responsável'
    find('form input[type="file"]').set(Rails.root.join('spec','support', 'yoga_icon.jpg'))
    click_on 'Cadastrar Categoria de Aula'

    expect(current_path).to eq class_category_path(ClassCategory.last)
    expect(page).to have_css('img[src*="yoga_icon.jpg"]')
    expect(page).to have_content('Yoga')
    expect(page).to have_content('Aulas para desestressar')
    expect(page).to have_content('Renato Teixeira')
    expect(page).to have_content('Editar Categoria de Aula')
    expect(page).to have_content('Excluir Categoria de Aula')
  end
end