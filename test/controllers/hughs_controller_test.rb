require 'test_helper'

class HughsControllerTest < ActionController::TestCase
  setup do
    @request.headers["Accept"] = 'application/json'
    @request.env['auth.wink.user_id'] = "12213"
  end

  test "create a Hugh" do
    post :create, { spark_core_id: "abc123994828939238478", spark_api_access_token: "pXU8sxQ9RpCiZ/FCzPPwjS2JWUX5Uuh7FxFgCYMOwVPUjuaRzgfd" }
    assert_response 201

    response_json = JSON.parse response.body
    assert_equal Hugh.find(response_json['id']).wink_user_id, "12213"
  end

  test "update a Hugh" do
    put :update, { id: hughs(:one).id, color: "deadbe", brightness: 75 }
    assert_response 204
  end

  test "update someone else's Hugh" do
    put :update, { id: hughs(:two).id, color: "fed555", brightness: 50 }
    assert_response 401
  end

  test "delete a Hugh" do
    delete :destroy, { id: hughs(:one).id }
    assert_response 204
  end

  test "delete someone else's Hugh" do
    delete :destroy, { id: hughs(:two).id }
    assert_response 401
  end
end
