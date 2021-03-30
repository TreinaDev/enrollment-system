class Enrollment < ApplicationRecord
  belongs_to :customer
  belongs_to :plan

  enum status: { inactive: 0, pending: 5, active: 10 }

  validates :payment_method, presence: true

  def approve_payment!
    data = { customer: customer.token, monthly_rate: plan.monthly_rate,
             payment_method: payment_method }
    response = Faraday.post 'http://localhost:5000/api/v1/approve_payment',
                            params: data
    if response.status == 200
      update!(status: :active)
    else
      update!(status: :pending)
    end
  end
end
