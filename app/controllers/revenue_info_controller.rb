class RevenueInfoController < ApplicationController
  def sales
    @from = params[:from]
    @to = params[:to]
    query = RevenueInfoQuery.new(@from, @to)
    @result = query.grouped
    if query.errors.present?
      return render json: { errors: query.errors.join(",") }, status: 422
    end
  end
end
