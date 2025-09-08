class SharesController < ApplicationController
  before_action :authenticate_user!

  def show
    @categories = current_user.categories.order(id: "desc")

    # 学習時間算出用パラメータ
    @date = if params[:date].present?
      Date.parse(params[:date]) rescue Date.current
    else
      Date.current
    end
    @category_id = params[:category_id].presence

    scope =
      if @category_id.present?
        current_user.logs.where(category_id: @category_id)
      else
        current_user.logs.where(category_id: nil) # カテゴリが未分類のログたち
      end

    @daily_minutes = scope.where(start_time: @date.all_day).sum(:duration).to_i
    @cumulative_minutes = scope.where("start_time <= ?", @date.end_of_day).sum(:duration).to_i
  end
end
