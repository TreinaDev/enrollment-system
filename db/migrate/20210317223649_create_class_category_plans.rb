class CreateClassCategoryPlans < ActiveRecord::Migration[6.1]
  def change
    create_table :class_category_plans do |t|
      t.references :class_category, null: false, foreign_key: true
      t.references :plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
