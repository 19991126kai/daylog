require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    sign_in users(:one)
    get categories_url
    assert_response :success
  end
end
