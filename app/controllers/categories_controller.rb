class CategoriesController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_q, only: [:index]

  def index
    @category = Category.find(params[:id])
    @posts = @category.posts.page(params[:page]).reverse_order
    @customer = current_customer
    @categories = Category.all
  end

  private

  def set_q
    @q = Post.ransack(params[:q])
  end
end
