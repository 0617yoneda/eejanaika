class PostsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_q, only: [:index, :search]
  before_action :ensure_correct_customer, only: [:edit, :update, :destroy]
  before_action :ensure_correct_guest, only: [:new]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      redirect_to posts_path
      flash[:notice] = "投稿しました"
    else
      render :new
    end
  end

  def index
    @posts = Post.page(params[:page]).reverse_order
    @customer = current_customer
    @categories = Category.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = PostComment.all
    @customer = @post.customer
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
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def search
    @customer = current_customer
    @post_searches = @q.result.page(params[:page]).reverse_order
  end
end

private

def set_q
  @q = Post.ransack(params[:q])
end

def post_params
  params.require(:post).permit(:category_id, :title, :body, :try, :image)
end

def ensure_correct_customer
  @post = Post.find(params[:id])
  unless @post.customer == current_customer
     redirect_to posts_path
  end
end

def ensure_correct_guest
  @customer = current_customer
  if @customer.email == 'guest@example.com'
     redirect_to posts_path
  end
end
