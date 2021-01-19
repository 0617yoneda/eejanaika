class CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update, :hide]
  before_action :ensure_correct_guest, only: [:edit, :update, :out, :hide]
  before_action :set_q, only: [:show]

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.page(params[:page]).reverse_order
    @categories = Category.all
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to posts_path
      flash[:notice] = "プロフィール編集完了です！"
    else
      render :edit
    end
  end

  def out
  end

  def hide
    @customer = current_customer
    @customer.update(is_deleted:true)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:nickname, :profile_image, :crazy, :word)
  end

  def ensure_correct_customer

    @customer = if params[:id]
                  Customer.find(params[:id])
                elsif params[:customer_id]
                  Customer.find(params[:customer_id])
                end
    redirect_to posts_path unless @customer == current_customer
  end

  def ensure_correct_guest
     @customer = current_customer
    if @customer.email == 'guest@example.com'
       redirect_to posts_path
    end
  end

  def set_q
    @q = Post.ransack(params[:q])
  end

end
