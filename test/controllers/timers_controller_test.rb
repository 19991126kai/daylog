require "test_helper"

class TimersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    sign_in users(:one)
    get timer_url
    assert_response :success
  end
end
