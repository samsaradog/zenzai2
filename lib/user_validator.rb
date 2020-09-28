class UserValidator < ActiveModel::Validator
  def validate(record)
    return unless record.email.present?
    return if record.errors[:email].any?

    before_plus = get_before_plus(record.email)
    matched = User.where("email ~* ?", before_plus)

    match_found = matched.any? do |user| 
      get_before_plus(user.email) == before_plus
    end

    record.errors[:email] << "is taken. Sorry, we only allow one subdomain email address" if match_found
  end

  def get_before_plus(string)
      string.split('@').first.split('+').first.downcase
  end
end
