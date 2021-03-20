class AddDescriptionAndResponsibleTeacherToClassCategory < ActiveRecord::Migration[6.1]
  def change
    add_column :class_categories, :description, :text, null: false
    add_column :class_categories, :responsible_teacher, :string, null: false
  end
end
