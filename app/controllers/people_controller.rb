class PeopleController < ApplicationController

# !PRIVATE! 
  private

  def person_params
  	params.require(:person).permit(:id, :first_name, :last_name, :sort_order,
  	                               sponsor_attributes:
  	                               [:id, :first_name, :last_name, :sort_order],
  	                               yizkors_attributes:
  	                               [:id, :first_name, :last_name, :sort_order])
  end

end
