require './lib/mailclerk'

desc "sends out daily dharma"
task :send_daily_dharma => :environment do
  Zenzai::MailClerk.new.send_daily_dharma
end
