require 'test_helper'
require 'test_helpers/admin_redirect_test'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include ::Devise::Test::IntegrationHelpers
  include AdminRedirectTest

  test 'redirect to root if not an admin' do
    assert_redirect_to_root_if_not_admin('/users')
  end

  test 'do not redirect if an admin' do
    assert_do_not_redirect_if_admin('/users')
  end
end
