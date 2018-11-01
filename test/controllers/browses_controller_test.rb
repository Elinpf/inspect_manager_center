require 'test_helper'

class BrowsesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get browses_show_url
    assert_response :success
  end

end
