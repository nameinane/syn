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


end