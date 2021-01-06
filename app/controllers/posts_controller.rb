class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    @post.save
    redirect_to posts_path
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end
end

private

  def post_params
    params.require(:post).permit(:category_id, :title, :body, :try, :image)
  end