class AddPaymentMethodToEnrollment < ActiveRecord::Migration[6.1]
  def change
    add_column :enrollments, :payment_method, :string
  end
end
