require 'digest/sha2'

class User < ActiveRecord::Base
  attr_reader :password

  validates :username, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  def password=(password)
    @password = password
    self.password_digest = Digest::SHA2.hexdigest(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)

    # no user with given username    
    return nil if user.nil?

    # check user's password
    password_digest = Digest::SHA2.hexdigest(password)
    user.password_digest == password_digest ? user : nil
  end
end
