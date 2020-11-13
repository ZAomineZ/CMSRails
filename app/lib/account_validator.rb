class AccountValidator
  include ActiveModel::Model

  attr_accessor :username, :password, :password_confirmation

  validates :username,
            presence: true,
            format: {with: /\A[a-zA-Z0-9_]{2,60}\z/},
            length: {minimum: 2, maximum: 60}
  validates :password,
            presence: true,
            length: {minimum: 5, maximum: 60}
  validates :password_confirmation,
            presence: true,
            length: {minimum: 5, maximum: 60}
  validate :password_identical

  private

  def password_identical
    unless password === password_confirmation
      errors.add(:password, 'Yours passwords aren\'t the same ')
    end
  end

end