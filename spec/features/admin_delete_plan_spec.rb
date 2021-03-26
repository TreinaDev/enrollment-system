require 'rails_helper'

feature 'Admin delete a plan' do
  scenario 'successfully' do
    allow(PaymentMethod).to receive(:all).and_return([])
    yoga = create(:class_category, name: 'Yoga')
    plan = create(:plan, name: 'Basico', monthly_rate: '100', monthly_class_limit: 10,
                         description: 'Ideal para iniciantes', class_categories: [yoga])
    admin = create(:user, role: :admin)
    login_as admin, scope: :user

    visit root_path
    click_on plan.name
    click_on 'Excluir Plano'

    expect(current_path).to eq root_path
    expect(Plan.count).to eq 0
    expect(page).to have_content('Plano deletado com sucesso')
  end
end
