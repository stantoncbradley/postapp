require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new({
                             city: "San Jose",
                             name: "Tester"
                           })
  end

  # Test validation

  test "should save valid user" do
    assert @user.save
  end

  test "should not save user without city" do
    @user.city = ''
    assert_not @user.save
  end

  test "should not save user without name" do
    @user.name = ''
    assert_not @user.save
  end
end
