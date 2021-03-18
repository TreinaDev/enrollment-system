class AddEmailAndTokenToCustomer < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :email, :string
    add_column :customers, :token, :string
  end
end
