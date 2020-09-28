require 'test_helper'
require './lib/user_validator'

class UserValidatorTest < ActionMailer::TestCase
  test 'passes for email not matching' do
    user = User.new(email: 'blah@123.com', password: 'abc123456')

    assert(user.valid?)
  end

  test 'fails if a plus address already exists' do
    user = User.new(email: 'with@123.com', password: 'abc123456')

    assert_not(user.valid?)
    assert_equal(user.errors[:email].size, 1)
  end

  test 'fails if matches another address without a plus' do
    user = User.new(email: 'admin+plus@123.com', password: 'abc123456')

    assert_not(user.valid?)
    assert_equal(user.errors[:email].size, 1)
  end
end

