class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :images

  def self.with_comments_and_images
    all.includes(:user, :images).order(created_at: :desc)
  end

  def self.index_response
    {posts: with_comments_and_images.map(&convert_to_hash)}
  end

  def convert_to_hash
    {
      id: post.id,
      title: post.title,
      author_name: post.user.name,
      author_city: post.user.city,
      images: post.images.pluck(:image_url)
    }
  end
end
