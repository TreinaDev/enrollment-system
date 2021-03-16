class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.string :name
      t.decimal :montlhy_rate
      t.integer :monthly_class_limit

      t.timestamps
    end
  end
end
