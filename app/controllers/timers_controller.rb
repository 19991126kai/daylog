class TimersController < ApplicationController
  before_action :authenticate_user!

  def show
    @log = current_user.logs.new
    @category = current_user.categories.find_by(id: params[:category_id])

    if @category
      @logs = current_user.logs
                        .where(category_id: @category.id)
                        .order(start_time: :desc)
                        .limit(20)
    else
      redirect_to root_path, alert: "無効なカテゴリです" and return
    end
  end
end
