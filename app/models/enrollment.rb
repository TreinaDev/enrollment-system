class Enrollment < ApplicationRecord
  belongs_to :customer
  belongs_to :plan

  enum status: { inactive: 0, pending: 5, active: 10 }

  # TODO: Implementar metodo
  # def self.approve_payment!(plan, customer)
  #   customer = Enrollment.find_by(customer: customer.id)
  #   data = {
  #     customer: customer, # token
  #     price: plan.price,
  #     payment_method: Customer.find_by(token: customer).payment_method
  #   }
  #   post 'payments/api/v1/approve_payment', params: data
  #   if status == 200
  #     customer.update!(status: :approved)
  #   else
  #     customer.update!(status: :pending)
  #   end
  # end
end
