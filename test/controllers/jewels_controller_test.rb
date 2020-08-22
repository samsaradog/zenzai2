require 'test_helper'
require 'test_helpers/admin_redirect_test'

class JewelsControllerTest < ActionDispatch::IntegrationTest
  include ::Devise::Test::IntegrationHelpers
  include AdminRedirectTest

  setup do
    @valid = jewels(:valid)
  end

  test 'redirect to root if not an admin' do
    assert_redirect_to_root_if_not_admin('/jewels')
  end

  test 'do not redirect if an admin' do
    assert_do_not_redirect_if_admin('/jewels')
  end


  class JewelsControllerWithAdminTest < JewelsControllerTest
    setup do
      sign_in users(:admin)
    end

    test 'index retrieves data for datatable' do
      get jewels_path, params: { format: 'json' }
      parsed = JSON.parse(@response.body)

      assert_equal(parsed['data'].first['origin'], 'blah')
    end

    test 'edit retrieves a jewel' do
      get edit_jewel_path(@valid)

      assert_response :success
    end

    test 'update changes a jewel' do
      newblah = 'blahblah'
      patch jewel_url(@valid), params: { jewel: { source: newblah } }

      assert_redirected_to jewels_path
      assert_equal(flash[:notice], 'Successful Update')

      assert_equal(@valid.reload.source, newblah)
    end

    test 'update fails with bad fields' do
      patch jewel_url(@valid), params: { jewel: { source: '' } }

      assert_redirected_to edit_jewel_path(@valid)
      assert_equal(flash[:notice], 'Update did not succeed')
      assert_equal(@valid.reload.source, 'blah')
    end
  end
end

