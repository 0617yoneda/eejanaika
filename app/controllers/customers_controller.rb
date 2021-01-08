class CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
  end

  def edit
  end

  def update
  end

  def out
  end

  def hide
  end
end
