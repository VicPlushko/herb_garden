class User < ActiveRecord::Base
  has_many :herbs
  has_secure_password
  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true  

  # def self.is_email_valid?(email)
  #   @email =~ /A[^@s] @[^@s] z/
  # end
    
end
