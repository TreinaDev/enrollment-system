FactoryBot.define do
  factory :plan do
    name { 'Basico' }
    monthly_rate { '100' }
    monthly_class_limit { 10 }
    max_dependents { 0 }
    description { 'Ideal para iniciantes' }
    status { :active }
  end
end
