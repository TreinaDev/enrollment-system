require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  context 'validations' do
    it { should belong_to(:customer) }
    it { should belong_to(:plan) }
  end

  context '#approve_payment' do
    it 'success' do
      # Arrange
      customer = create(:customer, token: '123')
      yoga = create(:class_category, name: 'Yoga')
      plan = create(:plan, name: 'PlanoFit', monthly_rate: 200, monthly_class_limit: 5)
      create(:class_category_plan, plan: plan, class_category: yoga)
      ccred = PaymentMethod.new(name: 'Cartão de Crédito', code: 'CCRED')
      allow(PaymentMethod).to receive(:all).and_return([ccred])
      enrollment = Enrollment.create!(customer: customer, plan: plan, payment_method: ccred)
      response = double('faraday_response', status: 200)
      allow(Faraday).to receive(:post).and_return(response)

      # Act
      enrollment.approve_payment!

      # Assert
      expect(enrollment.status).to eq 'active'
    end

    it 'fail on payment api' do
      # Arrange
      customer = create(:customer, token: '123')
      yoga = create(:class_category, name: 'Yoga')
      plan = create(:plan, name: 'PlanoFit', monthly_rate: 200, monthly_class_limit: 5)
      create(:class_category_plan, plan: plan, class_category: yoga)
      ccred = PaymentMethod.new(name: 'Cartão de Crédito', code: 'CCRED')
      allow(PaymentMethod).to receive(:all).and_return([ccred])
      enrollment = Enrollment.create!(customer: customer, plan: plan, payment_method: ccred)
      response = double('faraday_response', status: 400)
      allow(Faraday).to receive(:post).and_return(response)

      # Act
      enrollment.approve_payment!

      # Assert
      expect(enrollment.status).to eq 'pending'
    end
  end
end
