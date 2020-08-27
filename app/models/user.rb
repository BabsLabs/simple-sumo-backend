class User < ApplicationRecord
  before_create :confirmation_token

  has_secure_password

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :username, length: { minimum: 4 }
  validates :email, presence: true
  validates :email, uniqueness: true

  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP

  def verify_user
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  private

    def confirmation_token
      self.confirm_token = SecureRandom.urlsafe_base64.to_s if self.confirm_token.blank?
    end   

end
