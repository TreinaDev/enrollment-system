class Customer < ApplicationRecord
  validates :email, :name, :birthdate, presence: true
  validates :cpf, presence: true, uniqueness: { case_sensitive: false }
  validates :token, presence: true, uniqueness: true
  has_one :enrollment, dependent: :restrict_with_error

  def self.generate_token
    token = new_token
    token = new_token until Customer.find_by(token: token).nil?
    token
  end

  def self.new_token
    number = [*'a'..'z', *'A'..'Z', *0..9].shuffle.permutation(3)
    number.next.join
  end

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
