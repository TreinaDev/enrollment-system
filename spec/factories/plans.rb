FactoryBot.define do
  factory :plan do
    name { "MyString" }
    montlhy_rate { "9.99" }
    monthly_class_limit { 1 }
  end
end
