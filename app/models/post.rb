class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, inverse_of: 'post', dependent: :destroy
  has_many :comments, inverse_of: 'post', dependent: :destroy

  after_save :update_counter

  def recent_comments(lim = 5)
    comments.order(created_at: :desc).limit(lim)
  end

  private

  def update_counter
    author.increment!(:post_counter)
  end
end