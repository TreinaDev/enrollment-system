class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { user: 0, teacher: 5, admin: 10 }

  after_create :define_admin

  private

  def define_admin
    domain = email.split('@').last
    admin! if domain == 'smartflix.com.br'
  end
end
