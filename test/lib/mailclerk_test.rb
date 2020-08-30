require 'test_helper'
require './lib/mailclerk'

class MailClerkTest < ActionMailer::TestCase
  setup do
    @clerk = ::Zenzai::MailClerk.new
    @recipients = User.where(gets_daily_dharma: true)
  end

  test 'gets jewel for today' do
    assert_equal jewels(:number_2), @clerk.current_jewel
  end

  test 'adds the right users' do
    assert_same_elements @recipients, @clerk.daily_dharma_recipients
  end

  test 'sends out the mail' do
    @clerk.send_daily_dharma
    assert_same_elements @recipients.map(&:email), ActionMailer::Base.deliveries.last.bcc
  end
end
