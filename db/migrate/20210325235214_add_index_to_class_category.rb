class AddIndexToClassCategory < ActiveRecord::Migration[6.1]
  def change
    add_index :class_categories, :name, unique: true
    add_index :class_categories, :description, unique: true
  end
end
