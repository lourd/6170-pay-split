require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "does not save without first name" do
  	user = User.new(:first_name => "", :last_name => "test", :password => "test", 
  		:password_confirmation => "test", :email => "test")

  	assert_equal false, user.valid?
  end

  test "does not save without last name" do
  	user = User.new(:first_name => "test", :last_name => "", :password => "test", 
  		:password_confirmation => "test", :email => "test")

  	assert_equal false, user.valid?
  end

  test "does not save with incorrect characters in first name" do
  	user = User.new(:first_name => "test___';'.,", :last_name => "test", :password => "test", 
  		:password_confirmation => "test", :email => "test")

  	assert_equal false, user.valid?
  end

  test "does not save with incorrect characters in last name" do
  	user = User.new(:first_name => "test", :last_name => "test.,.;l'[]", :password => "test", 
  		:password_confirmation => "test", :email => "test")

  	assert_equal false, user.valid?
  end

  test "does not save without password field" do
  	user = User.new(:first_name => "test", :last_name => "test", :password => "", 
  		:password_confirmation => "test", :email => "test")

  	assert_equal false, user.valid?
  end

  test "does not save without passwords matching" do
  	user = User.new(:first_name => "test", :last_name => "test", :password => "test", 
  		:password_confirmation => "test1", :email => "test")

  	assert_equal false, user.valid?
  end

  test "does not save without email" do
  	user = User.new(:first_name => "test", :last_name => "test", :password => "test", 
  		:password_confirmation => "test", :email => "")

  	assert_equal false, user.valid?
  end

  test "user is valid with valid inputs" do
  	user = User.new(:first_name => "test", :last_name => "test", :password => "test", 
  		:password_confirmation => "test", :email => "test")

  	assert_equal true, user.valid?
  end

  test "correctly generates password hash and salt" do
   	user = User.new(:first_name => "test", :last_name => "test", :password => "test", 
  		:password_confirmation => "test", :email => "test")

   	user.encrypt_password

   	assert_equal user.password_hash, BCrypt::Engine.hash_secret("test", user.password_salt)
  end
end
