require 'test_helper'
require './lib/user_validator'

class UserValidatorTest < ActionMailer::TestCase
  test 'passes for email not matching' do
    user = User.new(email: 'blah@123.com', password: 'abc123456')

    assert(user.valid?)
  end

  test 'existing user is valid' do
    user = users(:valid)
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

  test 'fails if matches gmail address ignoring dots' do
    user = User.new(email: 'b.lah@gmail.com', password: 'abc123456')

    assert_not(user.valid?)
    assert_equal(user.errors[:email].size, 1)
  end

  test 'passes if not a gmail address and only difference is dots' do
    user = User.new(email: 'a.b.c@123.com', password: 'abc123456')

    assert(user.valid?)
  end

  test 'lets us make changes to users with gmail addresses' do
    user = users(:gmail)
    user.gets_daily_dharma = false

    assert(user.save)
  end

  test 'fails if email address not present' do
    user = User.new

    assert_not(user.valid?)
  end

  test 'fails for existing email' do
    user = users(:valid).dup

    assert_not(user.valid?)
  end
end

