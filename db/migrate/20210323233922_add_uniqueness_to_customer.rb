class AddUniquenessToCustomer < ActiveRecord::Migration[6.1]
  def change
    add_index(:customers, :cpf, unique: true)
    add_index(:customers, :token, unique: true)
  end
end
