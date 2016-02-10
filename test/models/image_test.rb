require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  def setup
    @image = Image.new({
                             post_id: 1,
                             image_url: "www.image_url.com"
                           })
  end

  # Test validation

  test "should save valid image" do
    assert @image.save
  end

  test "should not save image without post id" do
    @image.post_id = nil
    assert_not @image.save
  end

  test "should not save comment without image url" do
    @image.image_url = ''
    assert_not @image.save
  end
end
