class FavoritesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    favorite = Favorite.new
    favorite.customer_id = current_customer.id
    favorite.post_id = post.id
    favorite.save
    post.create_notification_favorite(current_customer)
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_customer.favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_to post_path(post)
  end
end
