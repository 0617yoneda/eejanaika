class CategoriesController < ApplicationController
  before_action :authenticate_customer!
  def index
    @category = Category.find(params[:id])
    @posts = @category. posts
    @customer = current_customer
  end
end
