require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    @comment = Comment.new({
                              post_id: 1,
                              user_id: 1,
                              content: "great article!"
                            })
  end

  # Test validation

  test "should save valid comment" do
    assert @comment.save
  end

  test "should not save comment without post id" do
    @comment.post_id = nil
    assert_not @comment.save
  end

  test "should not save comment without user id" do
    @comment.user_id = nil
    assert_not @comment.save
  end

  test "should not save comment without content" do
    @comment.content = ''
    assert_not @comment.save
  end

end
