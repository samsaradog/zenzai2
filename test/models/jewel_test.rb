require 'test_helper'

class JewelTest < ActiveSupport::TestCase
  setup do
    @valid = jewels(:valid)
  end

  test 'valid jewels' do
    assert_not_equal(Jewel.count, 0)
  end

  %i[source citation quote comment].each do |field|
    test "invalid without #{field.to_s}" do
      @valid.send("#{field}=", nil)

      assert_not(@valid.valid?)
      assert_not_empty(@valid.errors[field])
    end
  end
end
