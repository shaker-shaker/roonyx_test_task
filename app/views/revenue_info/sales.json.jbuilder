json.from @from
json.to @to

json.goods do
  json.array!(@result) do |res|
    json.title res["title"]
    json.revenue res["revenue"].to_d.round(2)
  end
end

json.total_revenue @result.map { |r| r["revenue"].to_d.round(2) }.sum
