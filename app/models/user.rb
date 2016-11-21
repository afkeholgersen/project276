class User < ApplicationRecord
	belongs_to :preference
	belongs_to :savedrecipe
	has_many :recipes
	has_many :comments, dependent: :destroy

	#does a validation of the password confirmation (checks if the password and password_confirmation matches)
	validates :password, confirmation: true


	#make sure these fields are not empty
	validates_presence_of :password, if: :password_changed?
	validates_presence_of :username
	validates_presence_of :email

	#validate email- at least looks like an email
	validates :email, email: true

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
    if self.password.present? && self.salt.present?
      if User.find(self.id).password == self.password
        self.password = self.password
        self.salt = self.salt
        return
      end
    end

    if self.password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password = BCrypt::Engine.hash_secret(password, salt)
    end

  end

  def self.curr_recipe_exists(user, param)
    recipe_exists = user.recipes.where(:recipe_id => param)
    recipe_exists.length
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password = BCrypt::Engine.hash_secret(password, salt)
    end
  end

end
