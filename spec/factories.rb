FactoryGirl.define do

  factory :user do
	  sequence(:name)  { |n| "Person #{n}" }
	  sequence(:email) { |n| "person_#{n}@great.rel"}
    password "realsecure,genius"
    password_confirmation "realsecure,genius"

    factory :admin do
    	admin true
    end
  end

  factory :account do
  	sequence(:tag) 	{ |n| "FG" + "0123456".split('').shuffle.join + n.to_s }
  	sequence(:name) { Faker::Name.name + " & Family" }
  end

  factory :address do
  	account
  	label { Faker::Name.prefix + " So-and-so's Factory Home" }
  	street1 { Faker::Address.street_address }
  	street2 { Faker::Address.secondary_address }
  	city { Faker::Address.city }
  	state { Faker::Address.state_abbr }
  	zip { Faker::Address.zip }
  	source { "faker" }
  end

  factory :mention do
  	association :mentionable, factory: :person
  	# association :mentionable, factory: :account
  	# TODO: currently, no testing is done for mentionable accounts
  	# 			perhaps, it could be done like so: http://stackoverflow.com/questions/7747945/factorygirl-and-polymorphic-associations
  end

  factory :payment do
  	account
  	amount { Random.new.rand(1..5)*18 }
  end

  factory :person, aliases: [:sponsor, :yizkor] do
  	account
  	first_name { Faker::Name.first_name }
  	last_name { Faker::Name.last_name }
  end

  factory :relationship do
  	yizkor 
  	sponsor 
  	kind "FG"
  	source "factory"
  end

end