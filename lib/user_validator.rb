class UserValidator < ActiveModel::Validator

  GMAIL_DOMAIN = 'gmail.com'

  def validate(record)
    return unless record.email.present? && record.errors[:email].empty?

    record.errors.add(:email, "is taken. We only allow one subdomain email address") if subdomain_duplicate(record)

    record.errors.add(:email, "is taken. We only allow one gmail dot address") if gmail_duplicate(record)
  end

  def subdomain_duplicate(record)
    before_plus = get_before_plus(record.email)
    domain = get_domain(record.email)

    matched = User.where("email ~* ?", before_plus).where("email ~* ?", domain)

    matched.any? do |user| 
      (get_before_plus(user.email) == before_plus) && (user != record)
    end
  end

  def get_before_plus(string)
    string.split('@').first.split('+').first.downcase
  end

  def get_domain(email_address)
    email_address.split('@').last
  end

  def gmail_duplicate(record)
    email_address = record.email
    username, domain = email_address.split('@')

    return false unless (domain == GMAIL_DOMAIN && record.new_record?)

    gmail_users = User.where('email ~* ?', GMAIL_DOMAIN)
    gmail_usernames = gmail_users.pluck(:email).map {|e| e.split('@').first }.map {|r| r.gsub('.','') }.uniq

    gmail_usernames.include?(username.gsub('.',''))
  end
end
