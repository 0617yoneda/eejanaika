class CategoriesController < ApplicationController
  before_action :authenticate_customer!
  def index
    @category = Category.find(params[:id])
    @posts = @category.posts.page(params[:page]).reverse_order
    @customer = current_customer
  end
end
