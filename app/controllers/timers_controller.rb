class TimersController < ApplicationController
  before_action :authenticate_user!

  def show
    @log = current_user.logs.build
    @category = current_user.categories.find_by(id: params[:category_id])

    unless @category
      redirect_to root_path, alert: "無効なカテゴリです" and return
    end

    # 何回もDBにアクセスしないように共通化
    base_logs = current_user.logs
                             .where(category_id: @category.id)
                             .order(study_date: :desc, id: :desc)

    @today_total_duration = base_logs.where(study_date: Date.current).sum(:duration)
    @total_duration       = base_logs.sum(:duration)

    @logs = base_logs.page(params[:page]).per(10)
  end
end
