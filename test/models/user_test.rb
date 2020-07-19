require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @valid = users(:valid)
  end

  test 'valid user' do
    assert_equal(User.count, 1)
  end

  test 'password too short' do
    user = User.new(password: 'short')
    assert_not(user.valid?)
    assert_equal(user.errors[:password].size, 1)
  end

  test 'bad email format' do
    user = User.new(email: 'abc')
    assert_not(user.valid?)
    assert_equal(user.errors[:email].size, 1)
  end

  test 'unique email' do
    user = User.new(email: @valid.email)
    assert_not(user.valid?)
    assert_equal(user.errors[:email].size, 1)
  end

  test 'ignores case when comparing email' do
    user = User.new(email: @valid.email.upcase)
    assert_not(user.valid?)
    assert_equal(user.errors[:email].size, 1)
  end

  test 'returning false when not an admin' do
    assert_not(@valid.is_admin?)
  end

  test 'returning true when admin' do
    @valid.is_admin = true
    assert(@valid.is_admin?)
  end

  test 'gets_daily_dharma defaults to false' do
    assert_not(User.new.gets_daily_dharma)
  end

  %i[email password].each do |field|
    test "invalid without #{field.to_s}" do
      user = User.new
      user.send("#{field}=", nil)

      assert_not(user.valid?)
      assert_not_empty(user.errors[field])
    end
  end

  %i[is_admin gets_daily_dharma].each do |field|
    test "requires #{field.to_s} to be boolean" do
      user = User.new
      user.send("#{field}=", nil)

      assert_not(user.valid?)
      assert_not_empty(user.errors[field])
    end

    [true, false].each do |option|
      test "allows #{field.to_s} to be '#{option.to_s}'" do
        user = User.new
        user.send("#{field}=", option)

        user.valid?
        assert_empty(user.errors[field])
      end
    end
  end
end
