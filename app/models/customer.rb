class Customer < ApplicationRecord
  has_one :enrollment, dependent: :restrict_with_error

  def hire_plan!(plan)
    if enrollment
      enrollment.plan = plan
      enrollment.save!
    else
      Enrollment.create(customer: self, plan: plan, status: :active)
    end
  end
end
