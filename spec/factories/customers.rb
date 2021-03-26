FactoryBot.define do
  factory :customer do
    name { 'Maria' }
    email { 'maria@email.com' }
    birthdate { '19/03/2000' }
    cpf { '123123123-12' }
    payment_method { '1' }
    token { '123' }
  end
end
