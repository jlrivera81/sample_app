require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
    							password: "foobar", password_confirmation: "foobar")
	end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end
  	
  	test "should be valid" do
    	assert @user.valid?
	end

	test "shold not be present" do
		@user.name = "   "
		assert_not @user.valid?
	end


  	test "email should be present" do
    	@user.email = "     "
    	assert_not @user.valid?
	end

	test "name should not be too long" do
    	@user.name = "a" * 51
    	assert_not @user.valid?
  	end


	test "email should not be too long" do
    	@user.email = "a" * 244 + "@example.com"
    	assert_not @user.valid?
	end

	test "email validation should accept valid addresses" do
    	valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    	valid_addresses.each do |valid_address|
      	@user.email = valid_address
      	assert @user.valid?, "#{valid_address.inspect} should be valid"
   	end
   end

   test "email validation should reject invalid addresses" do
   	invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    	invalid_addresses.each do |invalid_address|
      	@user.email = invalid_address
      	assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
		end 
	end

	test "email addresses should be unique" do
     	duplicate_user = @user.dup
     	duplicate_user.email = @user.email.upcase
     	@user.save
     	assert_not duplicate_user.valid?
	end

	test "password should have a minimum length" do
    	@user.password = @user.password_confirmation = "a" * 3
    	assert_not @user.valid?
  	end

  	test "email should be lower case" do
  		mixed_case_email = "JlRiVerA@gmail.COM"
  		@user.email = mixed_case_email
  		# before_save call-back on user object will downcase email before saving to DB
  		@user.save
  		assert_equal @user.reload.email, mixed_case_email.downcase
  	end

  	test "email should only have one dot in domain" do
  		invalidEmail = "jlrivera85@gmail.com"
  		@user.email = invalidEmail
  		@user.save
  		assert @user.valid?,  "#{invalidEmail} should be valid"
  	end
end
