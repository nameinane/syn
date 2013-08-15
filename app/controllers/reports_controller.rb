class ReportsController < ApplicationController


def holocaust_memorial

	@accounts = Mention.where(mentionable_type: "Account").map(&:mentionable)

	@accounts.sort! do |a, b|
    (a.sponsors.first.last_name <=> b.sponsors.first.last_name).nonzero? ||
    (a.tag <=> b.tag)
  end

  render layout: false

end

def yizkor_book

	@yizkors = Mention.where(mentionable_type: "Person", year: 2013).map(&:mentionable)

	@yizkors.sort! do |a, b|
    (a.sponsor.last_name <=> b.sponsor.last_name).nonzero? ||
    (a.account.tag <=> b.account.tag).nonzero? ||
    (a.account.name <=> b.account.name).nonzero? ||
    (a.sort_order <=> b.sort_order) ||
    (a.last_name <=> b.last_name) ||
    (a.first_name <=> b.first_name) 
  end

	render layout: false	
	# @yacc = ""

	# @yizkors.each do |y|
	# 	if y.sponsor.nil? then 
	# 		@yacc = @yacc + y.account.tag
	# 	end
	# end

end



end