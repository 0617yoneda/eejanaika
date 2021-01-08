class Admins::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
  end

  private

  def customer_params
    params.require(:customer).permit(:profile_image, :crazy, :word)
  end

end
