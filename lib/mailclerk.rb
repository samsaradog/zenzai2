require './lib/presenters/jewel_presenter'

module Zenzai
  class MailClerk
    def current_jewel
      current_delivery.jewel
    end

    def daily_dharma_recipients
      User.where(:gets_daily_dharma => true)
    end

    def send_daily_dharma
      UserMailer.daily_dharma(daily_dharma_recipients, 
                              Zenzai::JewelPresenter.new(current_jewel)).deliver_now
    end

    private

    def current_delivery
      Delivery.find_by_date(Date.today)
    end
  end
end
