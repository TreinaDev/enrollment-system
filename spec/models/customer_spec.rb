require 'rails_helper'

RSpec.describe Customer, type: :model do
  context 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cpf) }
    it { should validate_presence_of(:birthdate) }
    it { should validate_presence_of(:payment_method) }

    it { should validate_uniqueness_of(:cpf) }
    it { should validate_uniqueness_of(:token) }
  end
  
  context '.generate_token' do
    it 'should generate a token' do
      # Arrange

      # Act
      token = Customer.generate_token

      # Assert
      expect(token).not_to eq(nil)
      expect(token).to be_a_kind_of(String)
    end

    it 'token should be unique' do
      # Arrange
      data = File.read(Rails.root.join('spec/support/apis/customer.json'))
      Customer.create!(JSON.parse(data, symbolize_names: true))

      # Act
      allow(Customer).to receive(:generate_token).and_return('123')

      # Assert
      expect(Customer.generate_token).to eq('123')
    end
  end

  it '.new_token' do
    # Arrange

    # Act
    token = Customer.new_token

    # Assert
    expect(token).to be_a_kind_of(String)
    expect(token).not_to be(nil)
    expect(token.size).to eq(3)
  end
end
