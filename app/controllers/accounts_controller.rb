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

    # binding.pry
    # render 'edit'

    if @account.update_attributes(account_params)
      # update is good (note: use account_params to avoid malicious passing of other params)
      flash[:success] = "Changes saved.  Hope you like it this way better."
      # redirect_to account_path
      redirect_to edit_account_path
    else
      flash.now[:error] = "Changes not saved.  Look for errors below (or check logs).  Logs say:" + @account.errors.messages.inspect
      # Rails.logger.info(@account.errors.messages.inspect)
      render 'edit'
    end

  end

# !PRIVATE! 
  private

    def account_params
    	params.require(:account).permit(:tag, :name, 
                                      address_attributes: 
                                      [:id, :label, :street1, :street2, :city, :state, :zip],
                                      mentions_attributes: 
                                      [:id, :year, :mentionable_id, :mentionable_type, :source, :_destroy],
                                      people_attributes:
                                      [:id, :first_name, :last_name, :sort_order, :_destroy])
    end

end

                                      # people_attributes:
                                      # [:id, :first_name, :last_name, :sort_order, :_destroy],
                                      # sponsors_attributes:
                                      # [:id, :first_name, :last_name, :sort_order],
