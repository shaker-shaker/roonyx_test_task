RSpec.describe RevenueInfo, type: :model do
  it { should validate_uniqueness_of(:product_id).scoped_to(:trade_date) }
  it { should belong_to(:product) }
end
