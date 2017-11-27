class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :revenue_info, foreign_key: :product_id, class_name: "RevenueInfo", dependent: :destroy
end
