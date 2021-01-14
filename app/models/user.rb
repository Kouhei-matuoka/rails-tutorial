class User < ApplicationRecord
  attr_accessor :remember_token
  #before_save { self.email = email.downcase }

  #validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  #devise :omniauthable

  devise :omniauthable, omniauth_providers: %i(line)

  has_many :social_profiles, dependent: :destroy
  def social_profile(provider)
    social_profiles.select{ |sp| sp.provider == provider.to_s }.first
  end

  # 渡された文字列のハッシュ値を返します。
  def User.digest(string)
    cost = 
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end
  # ランダムなトークンを返します。
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end

  def self.from_omniauth(auth)
    user = find_or_create_by(uid: auth.uid, provider: auth.provider) do |user|
      user.email = "#{auth.uid}.#{auth.provider}.#{SecureRandom.hex(8)}@example.com"
      user.password = Devise.friendly_token[0, 20]
    end
    user
  end
end