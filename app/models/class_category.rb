class ClassCategory < ApplicationRecord
  has_many :class_category_plans, dependent: :destroy
  has_many :plans, through: :class_category_plans
  has_one_attached :icon, dependent: :destroy

  validates :name, :description, :responsible_teacher, presence: true
  validates :name, :description, uniqueness: true

  before_update :generate_image_url

  private

  def generate_image_url
    self.image_url = Rails.application.routes.url_helpers.url_for(icon) if icon.attached?
  end
end
