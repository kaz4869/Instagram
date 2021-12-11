class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post
    has_many :comment_likes, dependent: :destroy
    has_many :comment_liked_users, through: :comment_likes, source: :comment
end
