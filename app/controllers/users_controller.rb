class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def show
  	@user = User.find params[:id]
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      # sign the user in automatically
      sign_in @user
  		# good to go, kick 'em over to the profile page
  		flash[:success] = "You're in.  Congrats."
  		redirect_to @user
  	else
  		# show the form again
  		render 'new'
  	end

  end

  # !PRIVATE! 
  private

    def user_params
    	params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end


end
