class ClassCategory < ApplicationRecord
  has_many :class_category_plans, dependent: :destroy
  has_many :plans, through: :class_category_plans
end
