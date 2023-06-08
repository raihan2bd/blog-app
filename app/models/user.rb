class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id', inverse_of: 'author', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', inverse_of: 'author', dependent: :destroy
  has_many :comments, foreign_key: 'author_id', inverse_of: 'author', dependent: :destroy

  def recent_posts(lim = 3)
    posts.order(created_at: :desc).limit(lim)
  end
end
