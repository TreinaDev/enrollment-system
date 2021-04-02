FactoryBot.define do
  factory :enrollment do
    customer
    plan
    status { 'active' }
    enrolled_at { Time.zone.today }
  end
end
