FactoryBot.define do
  factory :plan do
    name { 'Basico' }
    monthly_rate { '100' }
    monthly_class_limit { 10 }
    description { 'Ideal para iniciantes' }
  end
end
