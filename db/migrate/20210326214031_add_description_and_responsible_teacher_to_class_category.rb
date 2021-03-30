class AddDescriptionAndResponsibleTeacherToClassCategory < ActiveRecord::Migration[6.1]
  def change
    add_column :class_categories, :description, :text
    add_column :class_categories, :responsible_teacher, :string
  end
end
