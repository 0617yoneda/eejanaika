class FavoritesController < ApplicationController
  before_action :authenticate_customer!
  def create
    if current_customer.email != "guest@example.com"
      @post = Post.find(params[:post_id])
      favorite = Favorite.new
      favorite.customer_id = current_customer.id
      favorite.post_id = @post.id
      favorite.save
      @post.create_notification_favorite(current_customer)
    else
      redirect_to request.referer
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_customer.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end
end
