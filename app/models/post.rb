class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :images

  validates_presence_of :title, :content
  validates_numericality_of :user_id

  def self.with_comments_and_images
    all.includes(:user, :images).order(created_at: :desc)
  end

  def self.index_response
    {posts: all.map(&:convert_to_hash)}
  end

  def convert_to_hash
    {
      id: id,
      title: title,
      author_name: user.name,
      author_city: user.city,
      images: images.pluck(:image_url)
    }
  end
end
