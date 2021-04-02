class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { user: 0, teacher: 5, admin: 10 }

  validate :only_create_if_company_domain

  after_create :define_admin

  private

  def define_admin
    domain = email.split('@').last
    admin! if domain == 'smartflix.com.br'
  end

  def only_create_if_company_domain
    domain = email.split('@').last
    errors.add(:email, 'Apenas emails autorizados') unless domain == 'smartflix.com.br'
  end
end
