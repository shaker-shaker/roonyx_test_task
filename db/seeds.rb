# Imports revenue data from worksheet. Returns a number of parsed cells
def import_revenue_data(worksheet)
  dates_row = worksheet.rows[0].drop(1)
  parsed = 0

  worksheet.rows.drop(1).each do |row|
    prod_name = row[0]
    prod = Product.find_or_initialize_by(name: prod_name)
    if prod.save
      row.drop(1).each_with_index do |cell, index|
        begin
          revenue_info = RevenueInfo.find_or_initialize_by(trade_date: dates_row[index].to_date, product: prod)
          revenue_info.revenue = cell.to_d
          revenue_info.save!
          parsed += 1
        rescue
          next
        end
      end
    end
  end
  parsed
end

# Checks if revenue data file is importable, returns worksheet with data if file is valid or nil in opposite case
def check_revenue_data_file(path)
  puts("Revenue data file is absent") unless File.exist?(path)

  workbook = SimpleXlsxReader.open(path)
  worksheet = workbook&.sheets&.first
  if worksheet.blank? || worksheet.rows.count < 2
    puts("Revenue data file is empty")
  else
    return worksheet
  end
end

ShellSpinner do
  worksheet = check_revenue_data_file(Rails.root.join("db", "seed_data", "revenue_data.xlsx"))
  return if worksheet.blank?

  puts(<<-EOT)
    Product revenue info import complete: successfully parsed cells - #{import_revenue_data(worksheet)}
  EOT
end
