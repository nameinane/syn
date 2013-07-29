class UsersController < ApplicationController
  before_action :signed_in_user,  only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: :destroy

  def index
    @users = User.paginate(page: params[:page]).per_page(50).search(params[:search])
  end

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

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end


  def edit
  end

  def update
    if @user.update_attributes(user_params)
      # update is good (note: use user_params to avoid malicious passing of other params)
      flash[:success] = "Changes saved.  Hope you like it this way better."
      sign_in @user
      redirect_to user_path
    else
      render 'edit'
    end

  end

  # !PRIVATE! 
  private

    def user_params
    	params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end


    # before filters
    def signed_in_user
      unless signed_in? 
        store_location
        redirect_to signin_url, notice: "Please sign in." 
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end



