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
    @posts = Post.page(params[:page]).reverse_order
    @customer = current_customer
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = PostComment.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end
end

private

  def post_params
    params.require(:post).permit(:category_id, :title, :body, :try, :image)
  end