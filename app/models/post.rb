class Post < ApplicationRecord
  belongs_to :customer
  belongs_to :category
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  attachment :image

  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

  # いいね通知作成
  def create_notification_favorite(current_customer)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_customer.id, customer_id, id, 'favorite'])
    if temp.blank?
      notification = current_customer.active_notifications.new(
        post_id: id,
        visited_id: customer_id,
        action: 'favorite'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # コメント通知作成
  def create_notification_post_comment!(current_customer, post_comment_id)
    temp_ids = PostComment.select(:customer_id).where(post_id: id).where.not(customer_id: current_customer.id).distinct
    temp_ids.each do |temp_id|
      save_notification_post_comment!(current_customer, post_comment_id, temp_id['customer_id'])
    end

    save_notification_post_comment!(current_customer, post_comment_id, customer_id) if temp_ids.blank?
  end

  def save_notification_post_comment!(current_customer, post_comment_id, visited_id)
    notification = current_customer.active_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'post_comment'
    )

    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
