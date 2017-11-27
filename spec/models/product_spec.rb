RSpec.describe Product, type: :model do
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:name) }
  it { should have_many(:revenue_info) }
end
