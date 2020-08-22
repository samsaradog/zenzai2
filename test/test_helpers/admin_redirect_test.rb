module AdminRedirectTest
  def assert_redirect_to_root_if_not_admin(path)
    sign_in users(:valid)
    get path

    assert_redirected_to root_path
  end

  def assert_do_not_redirect_if_admin(path)
    sign_in users(:admin)
    get path

    assert_response :success
  end
end
