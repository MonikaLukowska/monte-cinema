class PasswordLengthValidator < ActiveModel::Validator
  def validate(user)
    return if user.password.blank? || user.password.bytesize <= 72

    user.errors.add(:password, 'too long')
  end
end
