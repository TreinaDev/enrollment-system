class ClassCategory < ApplicationRecord
  has_many :class_category_plans
  has_many :plans, through: :class_category_plans
  has_one_attached :icon, :dependent => :destroy
end
