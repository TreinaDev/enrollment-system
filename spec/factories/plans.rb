FactoryBot.define do
  factory :plan do
    name { "Basico" }
    montlhy_rate { "100" }
    monthly_class_limit { 10 }
  end
end
