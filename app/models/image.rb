class Image < ActiveRecord::Base
  belongs_to :post

  validates_presence_of :image_url
  validates_numericality_of :post_id
end
