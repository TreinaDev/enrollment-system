class RemovePaymentMethodFromCustomer < ActiveRecord::Migration[6.1]
  def change
    remove_column :customers, :payment_method
  end
end
