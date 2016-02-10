require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @post = Post.new({
                             user_id: 1,
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
end
