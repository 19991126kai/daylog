class LogsController < ApplicationController
  before_action :authenticate_user!

  def index
    @logs = current_user.logs.preload(:category).order(date: :desc) # N+1問題の対策でカテゴリまでpreload。
  end
end
