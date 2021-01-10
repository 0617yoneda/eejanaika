class Admins::PostCommentsController < ApplicationController
  before_action :authenticate_admin!
  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to admins_posts_path
  end
end
