class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id', inverse_of: 'author', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', inverse_of: 'author', dependent: :destroy
  has_many :comments, foreign_key: 'author_id', inverse_of: 'author', dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :post_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  def recent_posts(lim = 3)
    posts.order(created_at: :desc).limit(lim)
  end
end
