require 'test_helper'
require 'test_helpers/presence_test'

class JewelTest < ActiveSupport::TestCase
  include PresenceTest

  setup do
    @valid = jewels(:valid)
  end

  test 'valid jewels' do
    assert_not_equal(Jewel.count, 0)
  end

  %i[source citation quote comment].each do |field|
    test "invalid without #{field.to_s}" do
      assert_presence(Jewel, field)
    end
  end
end
