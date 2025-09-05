class LogsController < ApplicationController
  before_action :authenticate_user!

  def index
    @logs = current_user.logs
                        .preload(:category) # N+1問題の対策でカテゴリまでpreload
                        .order(start_time: :desc)
                        .page(params[:page]).per(10) # ページネーション
  end

  def new
    now = Time.current.change(sec: 0)
    @log = current_user.logs.build(
      start_time: now - 25.minutes,
      end_time: now
    )
  end

  def create
    @log = current_user.logs.build(log_params)
    if @log.save
      redirect_to logs_path, notice: "ログを作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @log = current_user.logs.find(params[:id])
    @categories = Category.order(:name)
  end

  def update
    @log = current_user.logs.find(params[:id])
    if @log.update(log_params)
      redirect_to logs_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @log = current_user.logs.find(params[:id])
    @log.destroy
    redirect_to logs_path
  end

  private

  def log_params
    params.require(:log).permit(:category_id, :start_time, :end_time, :duration)
  end
end
