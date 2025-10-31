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
      category_id: params[:category_id],
      start_time: now - 25.minutes,
      end_time: now
    )
  end

  def create
    @log = current_user.logs.build(log_params)
    @log.duration = params[:log][:duration].to_i
    if @log.save
      redirect_to timer_path(category_id: @log.category_id), notice: "ログを作成しました"
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
    @log.assign_attributes(log_params)
    @log.duration = calc_duration(@log.start_time, @log.end_time)
    if @log.save
      redirect_to logs_path
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

  def calc_duration(start_time, end_time)
    ((end_time - start_time) / 60).to_i
  end
end
