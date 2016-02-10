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

  # Test by_post_and_root

  test "should filter out posts and children" do
    post = Post.create!({user_id: 1,
                        title: "new post",
                        content: "this is what I think."})
    comment = Comment.create!({user_id: 2,
                     post_id: post.id,
                     content: "I like what you think!"})
    Comment.create!({user_id: 2,
                     post_id: @comment.post_id,
                     parent_id: @comment.id,
                     content: "nice comment!"})
    Comment.create!({user_id: 1,
                     post_id: 2,
                     content: "this article was different!"})
    assert_equal [comment], Comment.by_post_and_root(post.id).to_a
  end

  # Test to_custom_hash

  test "should render recursive hash" do
    post = Post.create!({user_id: 1,
                         title: "new post",
                         content: "this is what I think."})
    comment = Comment.create!({user_id: 2,
                               post_id: post.id,
                               content: "I like what you think!"})
    nested = Comment.new({user_id: 1,
                              post_id: post.id,
                              parent: comment,
                              content: "I like that you like what I think!"})
    comment.add_child(nested)
    expected = {
      id: comment.id,
      user_id: comment.user_id,
      content: comment.content,
      comments: [{
        id: nested.id,
        user_id: nested.user_id,
        content: nested.content,
        comments: []
      }]
    }
    assert_equal expected, comment.to_custom_hash
  end

end
