class CategoriesController < ApplicationController
  def index
    @categories = current_user.categories.order(:created_at)
  end
end
