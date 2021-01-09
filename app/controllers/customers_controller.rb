class CustomersController < ApplicationController
  before_action :authenticate_customer!
  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to posts_path
  end

  def out
  end

  def hide
    customer = current_customer
    customer.update(is_deleted:true)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:nickname, :profile_image, :crazy, :word)
  end
end
