class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  scope :by_post, ->(post_id) {where(post_id: post_id)}
  scope :by_root, -> {where(parent_id: nil)}

  acts_as_tree order: 'created_at DESC'

  validates_presence_of :content
  validates_numericality_of :post_id, :user_id, greater_than: 0

  def self.by_post_and_root(post_id)
    by_post(post_id).by_root
  end

  def to_custom_hash
    responses = children.map { |ea| ea.to_custom_hash }
    {id: self.id, user_id: self.user_id, content: self.content, comments: responses}
  end

end
