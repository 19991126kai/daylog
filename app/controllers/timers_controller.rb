class TimersController < ApplicationController
  before_action :authenticate_user!

  def show
    @log = current_user.logs.build
    @category = current_user.categories.find_by(id: params[:category_id])

    if @category
      @logs = current_user.logs
                        .where(category_id: @category.id)
                        .order(study_date: :desc)
      @today_total_duration = @logs.where(study_date: Date.current).sum(:duration)
      @total_duration = @logs.sum(:duration)
    else
      redirect_to root_path, alert: "無効なカテゴリです" and return
    end
  end
end
