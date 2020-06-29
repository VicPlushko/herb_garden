class User < ActiveRecord::Base
  has_many :herbs
  has_secure_password
end
