require 'test_helper'

class UploadInspectInformationsControllerTest < ActionDispatch::IntegrationTest
  test "should get upload" do
    get upload_inspect_informations_upload_url
    assert_response :success
  end

end
