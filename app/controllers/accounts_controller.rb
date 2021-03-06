class AccountsController < ApplicationController

	def index
		@accounts = Account.search(params[:search])
	end

  def new
  	@account = Account.new
  end

  def show
  	@account = Account.find params[:id]
  end

  def edit
  	@account = Account.find params[:id]
  end

  def update
  	@account = Account.find params[:id]
    @yizkors = @account.yizkors

      render 'edit'


    # if @account.update_attributes(account_params)
    #   # update is good (note: use account_params to avoid malicious passing of other params)
    #   flash[:success] = "Changes saved.  Hope you like it this way better."
    #   # redirect_to account_path
    #   redirect_to edit_account_path
    # else
    #   render 'edit'
    # end

  end

# !PRIVATE! 
  private

    def account_params
    	params.require(:account).permit(:tag, :name, 
                                      people_attributes:
                                      [:id, :first_name, :last_name, :sort_order, :_destroy],
                                      sponsors_attributes:
                                      [:id, :first_name, :last_name, :sort_order],
                                      yizkors_attributes:
                                      [:id, :first_name, :last_name, :sort_order],
    	                                address_attributes: 
    	                                [:id, :label, :street1, :street2, :city, :state, :zip])
    end

end
