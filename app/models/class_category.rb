class ClassCategory < ApplicationRecord
  has_many :class_category_plans, dependent: :destroy
  has_many :plans, through: :class_category_plans
  has_one_attached :icon, dependent: :destroy

  validates :name, :description, :responsible_teacher, presence: true
  validates :name, :description, uniqueness: true
end
