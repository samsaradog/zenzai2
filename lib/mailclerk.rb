require './lib/presenters/jewel_presenter'

module Zenzai
  class MailClerk
    AWS_SENDING_LIMIT = 0.1

    def current_jewel
      current_delivery.jewel
    end

    def daily_dharma_recipients
      User.where(:gets_daily_dharma => true).where.not(confirmed_at: nil)
    end

    def send_daily_dharma
      presenter = Zenzai::JewelPresenter.new(current_jewel)
      daily_dharma_recipients.find_each do |recipient|
        UserMailer.daily_dharma(recipient, presenter).deliver_now
        sleep AWS_SENDING_LIMIT
      end
    end

    def notify_unconfirmed
      User.where(confirmed_at: nil).find_each do |recipient|
        recipient.send_confirmation_instructions
        sleep AWS_SENDING_LIMIT
      end
    end

    private

    def current_delivery
      Delivery.find_by_date(Date.today)
    end
  end
end
