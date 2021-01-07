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
end
