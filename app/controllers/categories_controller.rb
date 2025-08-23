class CategoriesController < ApplicationController
  def index
    @categories = current_user.categories.order(:created_at)
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      redirect_to categories_path
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
