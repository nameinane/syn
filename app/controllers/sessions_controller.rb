class SessionsController < ApplicationController

	def new
	end

	def create
		# render 'new'
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			# sign in fine
			sign_in user
			redirect_to user
		else
			# problem with email / password pair, render to try again
			flash.now[:error] = "Something wrong with your email / password combination.  Try again?"
			render 'new'
		end

	end

	def destroy
	end

	private

		def sign_in user
			flash[:information] = "Hi #{user.email}!"
		end

end
