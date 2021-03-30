class AddStatusToPlan < ActiveRecord::Migration[6.1]
  def change
    add_column :plans, :status, :integer, default: 0
  end
end
