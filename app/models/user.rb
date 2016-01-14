class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  before_save { self.name = name.downcase }
  before_create :create_remember_token

  validates :name, presence: true, length: {maximum: 20}, uniqueness: true
  validates :password, length: { minimum: 6, maximum: 20 }

  has_secure_password

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/images/:style/missing.png'
  validates_attachment_file_name :avatar, matches: [/png\Z/, /jpe?g\Z/]

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end