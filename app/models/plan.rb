class Plan < ApplicationRecord
  has_many :class_category_plans, dependent: :destroy
  has_many :class_categories, through: :class_category_plans
end
