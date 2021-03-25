require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  context 'validations' do
    it { should belong_to(:customer) }
    it { should belong_to(:plan) }
  end

  context '.approve_payment' do
    it 'success' do
      # Arrange
      # customer = create(:customer)
      # plan = create(:plan)

      # Act

      # Assert
    end
  end
end
