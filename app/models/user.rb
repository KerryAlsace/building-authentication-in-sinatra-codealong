class User < ActiveRecord::Base

  has_many :posts

  has_secure_password
    # adds 5 methods to User class

end
