require 'test_helper'

class HughsControllerTest < ActionController::TestCase
  setup do
    @request.headers["Accept"] = 'application/json'
  end

  test "create a Hugh" do
    post :create, { spark_core_id: "abc123994828939238478", spark_api_access_token: "pXU8sxQ9RpCiZ/FCzPPwjS2JWUX5Uuh7FxFgCYMOwVPUjuaRzgfd" }
    assert_response 201
  end

end
