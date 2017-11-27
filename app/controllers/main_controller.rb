class MainController < ApplicationController
  def index
    @result = RevenueInfoQuery.new(params[:from], params[:to]).grouped
  end
end
