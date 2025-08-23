class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = current_user.categories.order(:created_at)
  end

  def new
    @category = Category.new
  end

  def edit
    @category = current_user.categories.find(params[:id])
  end

  def update
    @category = current_user.categories.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      redirect_to categories_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    category = current_user.categories.find(params[:id]) # current_userにしておくと人のやつ勝手に消せなくなる
    category.destroy
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
