class UserMailer < ActionMailer::Base
  FROM = "Lexington Nichiren Buddhist Community <admin@zenzaizenzai.com>"
  SUBJECT = "Daily Dharma"
  default :from => FROM

  def daily_dharma(users, jewel_presenter)
    @jewel_presenter = jewel_presenter
    mail :to => FROM,
      :bcc => users.map(&:email),
      :subject => SUBJECT
  end
end
