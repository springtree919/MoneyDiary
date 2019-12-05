class User < ApplicationRecord
  has_many :incomes
  has_many :outgos
  attr_accessor :remember_token
  before_save { email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255}, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false} #文字の大小を区別しない
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  
  #ハッシュを返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  #トークンを作成(ログインの記憶に使用)
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  #tokenを作成、格納。またDBにdigestを保存
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  #ログイン時にcokkie側のtokenを認証
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  #tokenを削除
  def forget
    update_attribute(:remember_digest, nil)
  end
end