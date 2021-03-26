class AddDescriptionResponsibleTeacherToClassCategory < ActiveRecord::Migration[6.1]
  def change
    add_column :class_categories, :description, :text
    add_index :class_categories, :description, unique: true
    add_column :class_categories, :responsible_teacher, :string
    add_index :class_categories, :responsible_teacher, unique: true
  end
end
