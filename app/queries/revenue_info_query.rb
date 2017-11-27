# Public: class for searching grouped revenue data between two dates
#
# Example
#   RevenueInfoQuery.new("23-10-2017", "28-10-2017").grouped
#   => [{title: "Whool", revenue: "123.321"}, {title: "Steel", revenue: "1.22"}]
class RevenueInfoQuery
  attr_reader :errors

  def initialize(from, to)
    @errors = []
    begin
      @from = from.to_date unless from.blank?
      @to = to.to_date unless to.blank?
      errors << I18n.t("errors.invalid_date_range") if from.present? && to.present? && (from > to)
    rescue
      errors << I18n.t("errors.invalid_date_format")
    end
  end

  def grouped
    return {} if errors.count.positive?

    ActiveRecord::Base.connection.exec_query(
      <<-SQL
        SELECT p.name as title, sum(r_i.revenue) as revenue
        FROM revenue_infos r_i
        inner join products p on p.id = r_i.product_id
        #{where_date_interval_clause}
        group by r_i.product_id, p.name
        order by r_i.product_id;
      SQL
    ).to_hash
  end

  private

  def where_date_interval_clause
    str = ""
    if @from.present? || @to.present?
      str << "where"
      if @from.present?
        str << " r_i.trade_date >= cast('#{@from}' as date)"
        str << " and" if @to.present?
      end
      if @to.present?
        str << " r_i.trade_date <= cast('#{@to}' as date)"
      end
    end
    str
  end
end
