require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  include ::Devise::Test::IntegrationHelpers

  def current_user
    @current_user
  end

  class NotSignedInTest < ApplicationHelperTest
    test 'includes a home tab if not signed in' do
      assert_match "Home", header_tabs
    end

    test 'includes a sign in tab if not signed in' do
      assert_match "Sign in", header_tabs
    end

    test 'does not include a sign out tab if not signed in' do
      assert_no_match "Sign out", header_tabs
    end

    test 'does not include a profile tab if not signed in' do
      assert_no_match 'Profile', header_tabs
    end
  end

  class SignedInTest < ApplicationHelperTest
    setup do
      @current_user = users(:valid)
    end

    test 'includes a home tab if signed in' do
      assert_match "Home", header_tabs
    end

    test 'does not include a sign in tab if signed in' do
      assert_no_match "Sign in", header_tabs
    end

    test 'includes a profile tab if signed in' do
      assert_match 'Profile', header_tabs
    end

    test 'includes a sign out tab if signed in' do
      assert_match "Sign out", header_tabs
    end

    test 'does_not include the users tab if not an admin' do
      assert_no_match 'Users', header_tabs
    end

    test 'does_not include the jewels tab if not an admin' do
      assert_no_match 'Jewels', header_tabs
    end
  end

  class AdminSignedInTest < ApplicationHelperTest
    setup do
      @current_user = users(:admin)
    end

    test 'includes the users tab if an admin' do
      assert_match 'Users', header_tabs
    end

    test 'includes the jewels tab if an admin' do
      assert_match 'Jewels', header_tabs
    end
  end
end
