class MentionsController < ApplicationController

def index
  @mentionable = find_mentionable
  @mentions = @mentionable.mentions
end

def create
  @mentionable = find_mentionable
  @mention = @mentionable.mentions.build(mention_params)
  if @mention.save
    flash[:notice] = "Successfully created mention."
    redirect_to :id => nil
  else
    flash[:error] = "Could not create mention."
    redirect_to :id => nil
  end
end

def destroy
  binding.pry
  @mentionable = find_mentionable
  if @mention.destroy
    flash[:notice] = "Successfully deleted mention."
  else
    flash[:error] = "Could not delete mention."
  end
  @account = @mentionable.account
  redirect_to @account
end

private

def find_mentionable
  params.each do |name, value|
    if name =~ /(.+)_id$/
      return $1.classify.constantize.find(value)
    end
  end
  nil
end


# !PRIVATE! 
  private

    def mention_params
      params.require(:mention).permit(:year, :type)
    end


end
