require 'test_helper'

class DeliveryTest < ActiveSupport::TestCase
  %i[date jewel_id].each do |field|
    test "invalid without #{field.to_s}" do
      delivery = Delivery.new
      delivery.send("#{field}=", nil)
      delivery.valid?

      assert_not_empty(delivery.errors[field])
    end
  end

  test 'refers to a jewel' do
    jewel = jewels(:valid)
    delivery = Delivery.create(date: Time.now, jewel: jewel)

    assert_equal(delivery.jewel, jewel)
  end
end
