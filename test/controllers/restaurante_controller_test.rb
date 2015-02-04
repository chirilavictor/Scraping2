require 'test_helper'

class RestauranteControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get meniu_hora" do
    get :meniu_hora
    assert_response :success
  end

end
