class Customer < ApplicationRecord
  has_one :enrollment, dependent: :restrict_with_error

  def hire_plan!(plan)
    unless :cpf_blocked?
      if enrollment
        enrollment.update(plan: plan)
      else
        Enrollment.create(customer: self, plan: plan, status: :active)
      end
    else
      #erro
    end
  end

  private

  def cpf_blocked?
    response = Faraday.get("API/#{cpf}")
    json_response = JSON.parse(response.body)
    return json_response.blocked
  end

end

