class LogsController < ApplicationController
  before_action :authenticate_user!

  def index
    @logs = current_user.logs
                        .preload(:category) # N+1問題の対策でカテゴリまでpreload
                        .order(start_time: :desc)
                        .page(params[:page]).per(10) # ページネーション
  end

  def new
    @log = current_user.logs.build(
      category_id: params[:category_id],
    )
  end

  def create
    # フォームから手動で追加するとき
    if params[:log][:hours].present? && params[:log][:minutes].present?
      hours   = params[:log][:hours].to_i
      minutes = params[:log][:minutes].to_i
      total_minutes = (hours * 60) + minutes

      @log = current_user.logs.new(log_params.merge(duration: total_minutes))
    # タイマーを使って自動保存するとき
    else
      @log = current_user.logs.new(log_params)
    end

    if @log.save
      redirect_to timer_path(category_id: @log.category_id), notice: "ログを作成しました"
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    @log = current_user.logs.find(params[:id])
    @categories = Category.order(:name)
  end

  def update
    hours   = params[:log][:hours].to_i
    minutes = params[:log][:minutes].to_i
    total_minutes = (hours * 60) + minutes

    @log = current_user.logs.find(params[:id])
    @log.assign_attributes(log_params)
    @log.duration = total_minutes
    if @log.save
      redirect_to timer_path(category_id: @log.category_id), notice: "ログを編集しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @log = current_user.logs.find(params[:id])
    @log.destroy
    redirect_to request.referrer || root_path
  end

  private

  def log_params
    params.require(:log).permit(:category_id, :study_date, :duration)
  end
end
