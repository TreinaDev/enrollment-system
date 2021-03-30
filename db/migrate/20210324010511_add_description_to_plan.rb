class AddDescriptionToPlan < ActiveRecord::Migration[6.1]
  def change
    add_column :plans, :description, :string
  end
end
