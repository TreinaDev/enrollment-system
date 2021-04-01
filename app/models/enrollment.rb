class Enrollment < ApplicationRecord
  belongs_to :customer
  belongs_to :plan

  enum status: { active: 0, pending: 5, inactive: 10 }
end
