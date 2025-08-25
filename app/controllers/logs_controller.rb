class LogsController < ApplicationController
  before_action :authenticate_user!

  def index
    @logs = current_user.logs.preload(:category).order(start_time: :desc) # N+1問題の対策でカテゴリまでpreload。
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

  private

  def log_params
    params.require(:log).permit(:category_id, :start_time, :end_time)
  end
end
