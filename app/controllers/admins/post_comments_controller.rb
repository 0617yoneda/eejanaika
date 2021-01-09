class Admins::PostCommentsController < ApplicationController
  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to admins_posts_path
  end
end
