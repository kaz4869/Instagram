class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  validates :name, presence: true
  mount_uploader :image, ImageUploader

  has_many :posts, dependent: :destroy
  has_many :post_likes, dependent: :destroy
  has_many :post_liked_posts, through: :post_likes, source: :post
  def already_post_liked?(post)
    self.post_likes.exists?(post_id: post.id)
  end
  has_many :comment_likes, dependent: :destroy
  has_many :comment_liked_comments, through: :comment_likes, source: :comment
  def already_comment_liked?(comment)
    self.comment_likes.exists?(comment_id: comment.id)
  end

  has_many :relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :follower
  has_many :followers, through: :reverse_of_relationships, source: :following
  def follow(user_id)
    relationships.create(follower_id: user_id)
  end
  def unfollow(user_id)
    relationships.find_by(follower_id: user_id).destroy
  end
  def following?(user)
    followings.include?(user)
  end

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

end
