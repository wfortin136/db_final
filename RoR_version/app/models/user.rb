class User < ActiveRecord::Base

  has_secure_password

  validates :name, :password, presence: true
  validates :email, presence: true, uniqueness: true 
  validates :password, confirmation: true

end
