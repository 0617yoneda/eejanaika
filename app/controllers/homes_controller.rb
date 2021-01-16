class HomesController < ApplicationController
  def top
    @posts = Post.all.order(created_at: :desc).limit(4)
  end
end
