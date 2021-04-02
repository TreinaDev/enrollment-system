class AddMaxDependentsToPlan < ActiveRecord::Migration[6.1]
  def change
    add_column :plans, :max_dependents, :integer, default: 0
  end
end
