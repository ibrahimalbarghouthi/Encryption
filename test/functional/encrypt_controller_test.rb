require 'test_helper'

class EncryptControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
