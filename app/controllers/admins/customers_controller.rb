class Admins::CustomersController < ApplicationController
   before_action :authenticate_admin!
  def index
    @customers = Customer.all
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admins_posts_path
  end

  private

  def customer_params
    params.require(:customer).permit(:nickname, :profile_image, :crazy, :word)
  end
end
