require 'rails_helper'

# TODO: proteger rota com autenticacão de admin
feature 'Admin creates associated company users' do
  it 'and sees company details' do
    # Arrange
    create(:user)
    company = AssociatedCompany.create!(name: 'Tech Lab', 
                                        cnpj: '12.345.987/00001-12',
                                        manager: 'maria@techlab.com.br',
                                        contract_duration: 12)

    # Act
    login_as user
    visit root_path
    click_on 'Empresas parceiras'
    click_on company.name

    # Assert
    expect(current_path).to eq(associated_company_path(company))
    expect(page).to have_content(company.name)
    expect(page).to have_content(company.cpnj)
    expect(page).to have_content(company.manager)
    expect(page).to have_content('12 meses')
  end

  it 'success' do
    # Arrange
    create(:user)
    company = AssociatedCompany.create!(name: 'Tech Lab', 
                                        cnpj: '12.345.987/00001-12', 
                                        manager: 'maria@techlab.com.br', 
                                        contract_duration: 12)
                                        
    # Act
    login_as user
    visit root_path
    click_on 'Empresas parceiras'
    click_on company.name
    click_on 'Cadastrar funcionários'

    within ('form#associate_company') do
     attach_file 'Dados dos funcionários - ', Rails.root.join('spec', 'support', 'funcionarios.csv')
     click_on 'Enviar'
    end
    
    # Assert
    expect(current_path).to eq(associated_company_path(company))
    expect(page).to have_content('4 funcionários cadastrados')
    expect(page).to have_content('Ana Oliveira')
    expect(page).to have_content('Fernando Lourenço')
    expect(page).to have_content('Mauricio Teixeira')
    expect(page).to have_content('Patricia Sanches')
    expect(page).not_to have_link('Cadastrar funcionários')
  end
end