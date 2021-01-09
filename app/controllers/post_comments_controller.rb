class PostCommentsController < ApplicationController
  before_action :authenticate_customer!
  def create
    post = Post.find(params[:post_id])
    post_comment = PostComment.new(post_comment_params)
    post_comment.customer_id = current_customer.id
    post_comment.post_id = post.id
    post_comment.save
    post.create_notification_post_comment!(current_customer, post_comment.id)
    redirect_to post_path(post)
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to posts_path
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
