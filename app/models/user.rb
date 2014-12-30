class User < ActiveRecord::Base
  has_many :statuses, dependent: :destroy
  attr_accessor :remember_token, :activation_token

  # before_save {self.email = email.downcase}  
  before_save :downcase_email
  before_create :create_activation_digest
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates(:name, presence: true, length: {minimum: 1, maximum: 50})

  validates :email, 
    presence: true, 
    length: {minimum: 3, maximum: 255}, 
    format: {with: VALID_EMAIL_REGEX}, 
    uniqueness: {case_sensitive: false}

  has_secure_password
  
  validates :password, 
    length: {minimum: 6},
    allow_blank: true # has_secure_password makes sure passwords are filled upon signup

    # Returns the hash digest of the given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost

    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Return true if the given token matches the digest

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user
  def forget
    update_attribute(:remember_digest, nil)
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end


end
