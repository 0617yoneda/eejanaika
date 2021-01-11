class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  validates :nickname, presence: true

  def active_for_authentication?
        super && (self.is_deleted == false)
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.nickname = "ゲストユーザー"
      customer.password = SecureRandom.urlsafe_base64
    end
  end
end
