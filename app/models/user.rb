# User model class
class User < ApplicationRecord
  has_secure_password

  def subscriber?
    role == 'subscriber'
  end

  def admin?
    role == 'admin'
  end
end
