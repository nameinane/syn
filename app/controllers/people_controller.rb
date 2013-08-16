class PeopleController < ApplicationController
	# before_filter :load_account

def index
	@account = Account.find(params[:account_id])
  @people = @account.people
end

def create
	@account = Account.find(params[:person][:account_id])
	@sponsor = @account.sponsors.first
  @person = @account.people.build(person_params)
  if @person.save
    flash[:notice] = "Successfully created person."
    Relationship.create(sponsor_id: @sponsor.id, yizkor_id: @person.id, account_id: @account.id)
    flash[:notice] = "Successfully created relationship."    
    redirect_to action: :index, account_id: @account.id
  else
    flash[:error] = "Could not create person."
    redirect_to :id => nil
  end
end

def edit
	@person = Person.find params[:id]
end

def update
	@person = Person.find params[:id]

  # binding.pry
  # render 'edit'

  if @person.update_attributes(person_params)
    # update is good (note: use person_params to avoid malicious passing of other params)
    flash[:success] = "Changes saved.  Hope you like it this way better."
    # redirect_to person_path
    redirect_to edit_person_path
  else
    flash.now[:error] = "Changes not saved.  Look for errors below (or check logs).  Logs say:" + @person.errors.messages.inspect
    # Rails.logger.info(@person.errors.messages.inspect)
    render 'edit'
  end

end


def destroy
	@person = Person.find params[:id]
	if @person.destroy
		flash[:notice] = "Successfully deleted person."
	else
    flash[:error] = "Could not delete person."
  end
  @account = @person.account
	redirect_to @person.account
end


# !PRIVATE! 
  private

  def person_params
  	params.require(:person).permit(:id, :first_name, :last_name, :sort_order,
  	                               mentions_attributes: 
  	                               [:id, :year, :mentionable_id, :mentionable_type, :source, :_destroy],
  	                               )
  end

  def load_account
  	@account = Account.find(params[:account_id])
  end

end
