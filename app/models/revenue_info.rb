class RevenueInfo < ApplicationRecord
  validates_uniqueness_of :product_id, scope: :trade_date

  belongs_to :product
end
