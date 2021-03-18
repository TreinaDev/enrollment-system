FactoryBot.define do
  factory :plan do
    name { 'Essencial' }
    montlhy_rate { '9.99' }
    monthly_class_limit { 4 }
  end
end
