RSpec.describe RevenueInfoQuery do
  let(:product1) { create :product }
  let(:product2) { create :product }
  let!(:revenue_data1) { create :revenue_info, trade_date: "23-07-2017".to_date, product: product1, revenue: 2 }
  let!(:revenue_data2) { create :revenue_info, trade_date: "22-07-2017".to_date, product: product1, revenue: 3 }
  let!(:revenue_data3) { create :revenue_info, trade_date: "21-07-2017".to_date, product: product2, revenue: 4.444 }
  let!(:revenue_data4) { create :revenue_info, trade_date: "19-07-2017".to_date }

  describe "when date range is valid" do
    it "returns correct hash" do
      res = described_class.new("20-07-2017", "24-07-2017").grouped
      expect(res).to include("title" => product1.name, "revenue" => "5.0")
      expect(res).to include("title" => product2.name, "revenue" => "4.444")
    end
  end

  describe "when date range is invalid" do
    it "returns empty hash" do
      res = described_class.new("24-07-2017", "20-07-2017").grouped
      expect(res).to eq({})
    end
  end

  describe "when date format is invalid" do
    it "returns empty hash" do
      res = described_class.new("test", "20-07-2017").grouped
      expect(res).to eq({})
    end
  end

  describe "when only one date is present" do
    it "returns correct hash" do
      res = described_class.new("21-07-2017", "").grouped
      expect(res).to include("title" => product1.name, "revenue" => "5.0")
      expect(res).to include("title" => product2.name, "revenue" => "4.444")
    end
  end
end
