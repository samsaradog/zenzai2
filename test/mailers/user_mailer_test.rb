require 'test_helper'
require './lib/presenters/jewel_presenter'

class UserMailerTest < ActionMailer::TestCase
  test 'sending daily dharma' do
    jewel = jewels(:valid)
    presenter = ::Zenzai::JewelPresenter.new(jewel)

    user = users(:valid)

    email = UserMailer.daily_dharma(user, presenter)

    assert_emails 1 do
      email.deliver_now
    end

    address = UserMailer::FROM.match(/<(.*)>/)[1]

    assert_equal [address], email.from
    assert_equal [user.email], email.to
    assert_equal UserMailer::SUBJECT, email.subject
    assert_nil email.bcc
    assert_match jewel.citation, email.text_part.body.to_s
    assert_match jewel.citation, email.html_part.body.to_s
  end
end
