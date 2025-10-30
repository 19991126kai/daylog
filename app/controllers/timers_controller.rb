class TimersController < ApplicationController
  before_action :authenticate_user!

  def show
    @log = current_user.logs.new
    @category = current_user.categories.find_by(id: params[:category_id])

    if @category
      @logs = current_user.logs
                        .where(category_id: @category.id)
                        .order(start_time: :desc)
      @today_total_duration = @logs.where(start_time: Time.current.beginning_of_day..Time.current.end_of_day)
                                   .sum(:duration)
      @total_duration = @logs.sum(:duration)
    else
      redirect_to root_path, alert: "無効なカテゴリです" and return
    end
  end
end
