require 'test_helper'

class ImagesControllerTest < ActionController::TestCase
  setup do
    @image = images(:one)
  end

  test "should create image" do
    assert_difference('Image.count') do
      post :create, image: {
                    post_id: 1,
                    image_url: 'www.new_url.com'
                  }
    end

    assert_response 201
  end

  test "should destroy image" do
    assert_difference('Image.count', -1) do
      delete :destroy, id: @image
    end

    assert_response 204
  end
end
