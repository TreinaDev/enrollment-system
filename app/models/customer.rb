class Customer < ApplicationRecord
  has_one :enrollment, dependent: :restrict_with_error

  def hire_plan!(plan)
    if cpf_blocked?
      errors.add :customer, message: 'A matrícula não pode ser efetivada\
                                        poque o CPF informado está bloqueado'
    elsif enrollment
      enrollment.update(plan: plan)
    else
      create_enrollment(plan: plan)
    end
  end

  private

  def cpf_blocked?
    response = Faraday.get("API/#{cpf}")
    json_response = JSON.parse(response.body)
    json_response['blocked']
  end
end
