require 'rails_helper'

describe User do
  context 'Validation' do
    it 'should automatically insert account with domain @smartflix in admin' do
      user = create(:user, email: 'maria@smartflix.com.br')

      expect(user.role).to eq 'admin'
    end

    it 'should register other accounts as role user' do
      user = create(:user, email: 'maria@flix.com.br')

      expect(user.role).to eq 'user'
    end
  end
end
