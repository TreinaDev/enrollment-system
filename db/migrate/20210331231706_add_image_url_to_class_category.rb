class AddImageUrlToClassCategory < ActiveRecord::Migration[6.1]
  def change
    add_column :class_categories, :image_url, :string
  end
end
