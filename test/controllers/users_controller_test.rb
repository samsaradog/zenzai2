require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include ::Devise::Test::IntegrationHelpers

  test 'redirect to root if not an admin' do
    sign_in users(:valid)
    get '/users'

    assert_redirected_to root_path
  end

  test 'do not redirect if an admin' do
    sign_in users(:admin)
    get '/users'

    assert_response :success
  end
end
