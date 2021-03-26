class AddPaymentMethodToCustomer < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :payment_method, :integer
  end
end
