require 'bcrypt'
class Account < ApplicationRecord

  attr_accessor :remember_token, :activation_token
  before_save   :downcase_email
  before_create :create_activation_digest

  validates :name, presence: true, length: {maximum: 15}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },uniqueness: {case_sensitive: false}
  validates :passsword, presence: true, length: {maximum:50}

    # Returns the hash digest of the given string.
    def self.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def self.new_token
      SecureRandom.urlsafe_base64
    end

    # Returns true if the given token matches the digest.
      def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
      end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = Account.new_token
    update_attribute(:remember_digest, Account.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  private

     # Converts email to all lower-case.
     def downcase_email
       self.email = email.downcase
     end

     # Creates and assigns the activation token and digest.
     def create_activation_digest
       self.activation_token  = Account.new_token
       self.activation_digest = Account.digest(activation_token)
     end

end
