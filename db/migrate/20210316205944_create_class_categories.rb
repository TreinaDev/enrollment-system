class CreateClassCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :class_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
