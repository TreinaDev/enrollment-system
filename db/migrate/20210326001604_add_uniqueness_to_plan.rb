class AddUniquenessToPlan < ActiveRecord::Migration[6.1]
  def change
    add_index(:plans, :name, unique: true)
  end
end
