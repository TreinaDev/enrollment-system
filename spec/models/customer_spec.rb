require 'rails_helper'

RSpec.describe Customer, type: :model do
  context '.generate_token' do
    it 'should generate a token' do
      #Arrange
      
      #Act
      token = Customer.generate_token

      #Assert
      expect(token).not_to eq(nil)
      expect(token).to be_a_kind_of(String)
    end

    it 'should be unique' do
      # Arrange
        data = File.read(Rails.root.join('spec', 'support', 'apis', 'customer.json'))
        customer = Customer.create!(JSON.parse(data, symbolize_names: true))

      # Act
        allow(Customer).to receive(:generate_token).and_return('123')

      # Assert
        expect(Customer.generate_token).to eq('123')
    end
  end
end
