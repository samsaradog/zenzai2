require 'test_helper'
require './lib/presenters/jewel_presenter'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test 'shows the home page' do
    get '/'
    assert_response :success
    assert_match 'Welcome', @response.body
    assert_kind_of(Zenzai::JewelPresenter, assigns(:jewel_presenter))
  end

  %w[about support zenzai].each do |name|
    test "shows the #{name} page" do
      get "/pages/#{name}"
      assert_response :success
      assert_match name.capitalize, @response.body
    end
  end
end
