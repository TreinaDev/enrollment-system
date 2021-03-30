require 'rails_helper'

feature 'Admin inactivate a plan' do
  scenario 'successfully' do
    allow(PaymentMethod).to receive(:all).and_return([])
    yoga = create(:class_category, name: 'Yoga')
    plan = create(:plan, name: 'Basico', monthly_rate: '100', monthly_class_limit: 10,
                         description: 'Ideal para iniciantes', class_categories: [yoga])
    admin = create(:user, role: :admin)
    login_as admin, scope: :user

    visit root_path
    click_on plan.name
    click_on 'Inativar Plano'

    expect(current_path).to eq root_path
    expect(Plan.count).to eq 1
    expect(Plan.last.status).to eq 'inactive'
    expect(page).to have_content('Plano inativado com sucesso')
  end
end
