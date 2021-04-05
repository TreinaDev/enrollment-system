class Plan < ApplicationRecord
  has_many :class_category_plans, dependent: :destroy
  has_many :class_categories, through: :class_category_plans

  validates :name, :monthly_rate, :monthly_class_limit, :description, presence: true
  validates :name, uniqueness: true
  validates :monthly_rate, :monthly_class_limit, numericality: { greater_than: 0 }

  enum status: { active: 0, inactive: 10 }

  def self.active
    Plan.where('status == ?', 0)
  end
end
