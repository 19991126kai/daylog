class TimersController < ApplicationController
  before_action :authenticate_user!

  def show
    @log = current_user.logs.new
    @categories = current_user.categories.order(:id)
  end
end
