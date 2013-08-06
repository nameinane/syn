namespace :db do
	desc "Fill database with sample data"
		task populate_users: :environment do
			User.create!(name: "Name Inane",
			             email: "nameinane@gmail.com",
			             password: "foobar",
			             password_confirmation: "foobar",
			             admin: true)
			99.times do |n|
				name = Faker::Name.name
				email = "example-#{n}@funrail.org"
				password = "password"
				User.create(name: name,
				            email: email,
				            password: password,
				            password_confirmation: password)			
			end
		end

		task populate_syn: :environment do
			# load up accounts (they all end in "& Family")
			5.times do
				tag = "FK" + "0123456".split('').shuffle.join
				name = Faker::Name.name + " & Family"
				Account.create(tag: tag, name: name)
			end

			# populate people 
			Account.all.each do |acc|
				Random.new.rand(2..8).times do
					first_name = Faker::Name.first_name
					last_name =  Faker::Name.last_name
					acc.people.create(first_name: first_name,
					                  last_name: last_name,
					                  sort_order: Random.new.rand(100..2000),
					                  source: "faker")
				end
			end

			# populate relationships 
			# TODO: improve upon the schema where the first person is owner and all others are yizkors
			Account.all.each do |acc|
				sponsor_id = acc.people.first.id
				acc.people.each do |p|
					Relationship.create(sponsor_id: acc.people.first.id, 
					                    yizkor_id: p.id, 
					                    kind: nil,
					                    source: "faker") unless p.id == sponsor_id
				end
			end

			# populate address
			Account.all.each do |acc|
				label = Faker::Name.prefix + " " + acc.people.first.first_name + " " + acc.people.first.last_name
				street1 = Faker::Address.street_address
				street2 = Faker::Address.secondary_address
				city = Faker::Address.city
				state = Faker::Address.state_abbr
				zip = Faker::Address.zip
				acc.address.create(label: label, 
				                     street1: street1, 
				                     street2: street2,
				                     city: city,
				                     state: state,
				                     zip: zip,
				                     source: "faker")
			end

			# populate payments 
			Account.all.each do |acc|
				Random.new.rand(1..5).times do
					acc.payments.create(amount: Random.new.rand(1..5)*18,
					                    source: "faker") unless Random.new.rand(0..4) == 4
					acc.payments.create(amount: Random.new.rand(1..5)*18,
					                    source: "faker", year: 1.year.ago.year) unless Random.new.rand(0..1) == 0
				end
			end

			# populate mentions
			Account.all.each do |acc|
				acc.mentions.create unless Random.new.rand(0..2) == 0
				acc.mentions.create(year: 1.year.ago.year) unless Random.new.rand(0..1) == 0
				acc.people.each do |p|
					p.mentions.create	unless Random.new.rand(0..2) == 0
					p.mentions.create(year: 1.year.ago.year) unless Random.new.rand(0..1) == 0
				end
			end

		end

end

