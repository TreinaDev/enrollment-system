FactoryBot.define do
  factory :enrollment do
    customer
    plan
    status { 'active' }
  end
end
