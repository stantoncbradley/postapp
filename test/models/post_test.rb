require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    user = User.create!({
      name: "Fly",
      city: "Oakland"
    })
    @post = Post.new({
                             user_id: user.id,
                             title: "Ruby is great",
                             content: "It is very powerful."
                           })
  end

  # Test validation

  test "should save valid post" do
    assert @post.save
  end

  test "should not save post without user id" do
    @post.user_id = nil
    assert_not @post.save
  end

  test "should not save post without title" do
    @post.title = ''
    assert_not @post.save
  end

  test "should not save post without content" do
    @post.content = ''
    assert_not @post.save
  end

  # Test convert_to_hash

  test "should return expected hash" do
    @post.save!
    expected = {
      id: @post.id,
      title: @post.title,
      author_name: @post.user.name,
      author_city: @post.user.city,
      images: []
    }
    assert_equal expected, @post.convert_to_hash
  end

end
