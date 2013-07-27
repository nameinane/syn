class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			# sign in fine
			sign_in user
			redirect_back_or user
		else
			# problem with email / password pair, render to try again
			flash.now[:error] = "Something wrong with your email / password combination.  Try again?"
			render 'new'
		end

	end

	def destroy
		sign_out
		redirect_to root_url
	end

end
