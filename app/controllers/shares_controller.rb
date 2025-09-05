class SharesController < ApplicationController
  def show
    @categories = current_user.categories.order(id: "desc")

    # 学習時間算出用パラメータ
    @date = if params[:date].present?
      Date.parse(params[:date]) rescue Date.current
    else
      Date.current
    end
    @category_id = params[:category_id].presence || @categories.first&.id
  end
end
