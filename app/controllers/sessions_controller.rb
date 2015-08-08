class SessionsController < ApplicationController
  def new
  		
  end

  def create
		@user = User.find_by(email: params[:session][:email].downcase)
		if @user && @user.authenticate(params[:session][:password])
			log_in @user
			params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)

			# rails automatically converts to users_url(usedr)
			redirect_back_or @user
		else
			# a "flash" persists for exactly 1 web "request"
			# unlike "redirect" (which was used for successful user_controller flash), render doesn't send web_request
			# therefore, once the new login form is rendered and you click on another link, the flash will still be there 
			# for the first request
			flash.now[:danger] = 'Invalid email/password combination' # Not quite right!

		   render 'new'
		end
  end

  def destroy
  		log_out if logged_in?
  		redirect_to root_url
  end
end
