RSpec.describe "Sales", type: :request do
  let(:product1) { create :product }
  let(:product2) { create :product }
  let!(:revenue_data1) { create :revenue_info, trade_date: "23-07-2017".to_date, product: product1, revenue: 2 }
  let!(:revenue_data2) { create :revenue_info, trade_date: "22-07-2017".to_date, product: product1, revenue: 3 }
  let!(:revenue_data3) { create :revenue_info, trade_date: "21-07-2017".to_date, product: product2, revenue: 4.444 }
  let!(:revenue_data4) { create :revenue_info, trade_date: "19-07-2017".to_date }

  context "when date is valid" do
    it "returns correct json" do
      get "/sales?from=20-07-2017"
      resp = JSON.parse(response.body)
      expect(resp["total_revenue"]).to eq("9.44")
    end
  end

  context "when date is invalid" do
    it "returns correct json" do
      get "/sales?from=test"
      resp = JSON.parse(response.body)
      expect(resp["errors"]).to include("Incorrect date format")
    end
  end

  context "when date range is invalid" do
    it "returns correct json" do
      get "/sales?from=20-07-2017&to=10-07-2017"
      resp = JSON.parse(response.body)
      expect(resp["errors"]).to include("Incorrect date range")
    end
  end
end
