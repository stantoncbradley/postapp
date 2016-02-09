class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  scope :by_post, ->(post_id) {where(post_id: post_id)}

  acts_as_tree order: 'created_at DESC'



end
