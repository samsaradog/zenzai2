require 'test_helper'
require 'test_helpers/presence_test'

class DeliveryTest < ActiveSupport::TestCase
  include PresenceTest

  %i[date jewel_id].each do |field|
    test "invalid without #{field.to_s}" do
      assert_presence(Delivery, field)
    end
  end

  test 'refers to a jewel' do
    jewel = jewels(:valid)
    delivery = Delivery.create(date: Time.now, jewel: jewel)

    assert_equal(delivery.jewel, jewel)
  end
end
