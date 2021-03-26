FactoryBot.define do
  factory :user do
    email { 'user@smartflix.com.br' }
    password { '123456' }
    role { 'admin' }
  end
end
