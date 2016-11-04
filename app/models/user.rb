class User < ApplicationRecord
	belongs_to :preference
	belongs_to :savedrecipe

	#does a validation of the password confirmation (checks if the password and password_confirmation matches)
	validates :password, confirmation: true


	#make sure these fields are not empty
	validates_presence_of :password, if: :password_changed?
	validates_presence_of :username
	validates_presence_of :email


	#makes sure username is not taken
	validates_uniqueness_of :username

 	before_save :encrypt_password
  
  #need to use self so that we can call it like a static method (User.authenticate)
  def self.authenticate(username, password)
    user = find_by_username(username)
    if user && user.password == BCrypt::Engine.hash_secret(password, user.salt)
      user
    else
      nil
    end
  end
  
  #method to salt and create the encrypted password
  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password = BCrypt::Engine.hash_secret(password, salt)
    end
  end

end
