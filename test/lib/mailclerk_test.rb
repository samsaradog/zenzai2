require 'test_helper'
require './lib/mailclerk'

class MailClerkTest < ActionMailer::TestCase
  setup do
    @clerk = ::Zenzai::MailClerk.new
    @recipients = User.where(gets_daily_dharma: true).where.not(confirmed_at: nil)
  end

  test 'gets jewel for today' do
    assert_equal jewels(:number_2), @clerk.current_jewel
  end

  test 'adds the right users' do
    assert_same_elements @recipients, @clerk.daily_dharma_recipients
  end

  test 'sends out the mail' do
    @clerk.send_daily_dharma
    addresses = ActionMailer::Base.deliveries.map(&:to).flatten

    assert_same_elements @recipients.map(&:email), addresses
  end

  test 'sends notifications to unconfirmed users' do
    unconfirmed = User.where(confirmed_at: nil, gets_daily_dharma: true)

    @clerk.notify_unconfirmed
    addresses = ActionMailer::Base.deliveries.map(&:to).flatten

    assert_same_elements unconfirmed.map(&:email), addresses
  end
end
