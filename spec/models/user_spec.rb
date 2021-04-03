require 'rails_helper'

describe User do
  context 'Validation' do
    it 'user must have domain @smartflix' do
      user = create(:user, email: 'maria@smartflix.com.br')

      expect(user.role).to eq 'admin'
      expect(User.last).to eq user
    end

    it 'cannot create user account if domain is not @smartflix.com.br' do
      valid_user = create(:user, email: 'maria@smartflix.com.br')
      invalid_user = User.create(email: 'maria@flix.com.br', password: '123456')

      expect(invalid_user.valid?).to eq false
      expect(User.last).to eq valid_user
    end
  end
end
