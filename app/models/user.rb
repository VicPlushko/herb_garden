class User < ActiveRecord::Base
  has_many :herbs
  has_secure_password
  validates :name, :email, :password, presence: true
  validates :email, 
  format: { with: /A[^@s] @[^@s] z/, message: "Email invalid"  },
  uniqueness: true,
  length: { minimum: 4, maximum: 254 }  

  def self.is_email_valid?(email)
    @email =~ /A[^@s] @[^@s] z/
  end
    
end
