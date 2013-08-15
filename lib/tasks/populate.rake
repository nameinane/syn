namespace :populate do
	desc "Fill database with data (fake or legacy)"
		task users: :environment do
			User.create!(name: "Name Inane",
			             email: "nameinane@gmail.com",
			             password: "foobar",
			             password_confirmation: "foobar",
			             admin: true)
			# TODO: in case more users are needed, enable below block
			0.times do |n|
				name = Faker::Name.name
				email = "example-#{n}@funrail.org"
				password = "password"
				User.create(name: name,
				            email: email,
				            password: password,
				            password_confirmation: password)			
			end
		end

		task syn_fake: :environment do
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
				acc.create_address(label: label, 
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

		# TODO: for some reason this task does not show up under "rake -T"
		task syn_legacy: :environment do
			# TODO: change path to be dynamic
			require	'~/syn/lib/tasks/legacy_classes.rb'

			# TODO: use logger!
			# TODO: use temporary tables, then 1) report on number of objects created and
			# 2) ask if database should be overwritten with new info
			begin
				
				input = ''
				puts "You are about to destroy all data in the database concerning:"
				puts "accounts, people, relationships, addresses, payments, and mentions."
				puts "Are you sure you want to proceed?"
				puts "type 'destroy' to confirm:"
				input = 'destroy' # STDIN.gets.chomp
				if ['destroy'].include? input then

					# empty destination tables
					# Account.send 				("#{input}_all")
					# Address.send 				("#{input}_all")
					# Payment.send 				("#{input}_all")
					# Person.send 				("#{input}_all")
					# Relationship.send 	("#{input}_all")
					# Mention.send 				("#{input}_all")
					# Address.send 				("#{input}_all")
					# Payment.send 				("#{input}_all")

			# tables_to_kill = ['accounts', 'people', 'relationships', 
			# 									'addresses', 'payments', 'mentions']
			tables_to_kill = ['mentions']

					tables_to_kill.each do |table_name|
						ActiveRecord::Base.connection.execute("DELETE FROM #{table_name};")					
					end

					# show resulting stats
					puts "accounts: " + Account.count.to_s + " records."
					puts "addresses: " + Address.count.to_s + " records."
					puts "payments: " + Payment.count.to_s + " records."
					puts "people: " + Person.count.to_s + " records."
					puts "relationships: " + Relationship.count.to_s + " records."
					puts "mentions: " + Mention.count.to_s + " records."
					puts

					# populate accounts
			# puts "Creating accounts.."
			# LegacyAccounts.all.each do |la|
			# 	Account.create!(tag: la.account_tag, name: la.book_name)
			# end
			# puts "accounts now has:" + Account.count.to_s + " records."
			# puts

					# TODO: make this more resilient -- what if no account found?  what if creating a person fails?
					# TODO: some accounts have people with names set to 'null' -- need to deal with that 
					# populate people
					# TODO: what if sponsor and yizkor have the same names?  how will find_or_create_by work? -- OK because of different 'sort_order'
			# puts "Creating people and relationships.."
			# LegacyPeople.all.each do |lp|
			# 	account = Account.find_by(tag: lp.account_tag)

			# 	sponsor = Person.find_or_create_by(account_id: account.id, first_name: lp.sponsor_first_name, 
			# 	                         last_name: lp.sponsor_last_name, sort_order: 0, 
			# 	                         source: lp.source) 
			# 	yizkor = Person.find_or_create_by(account_id: account.id, first_name: lp.yizkor_first_name, 
			# 	                         last_name: lp.yizkor_last_name, sort_order: lp.sort_order*1000, 
			# 	                         source: lp.source) 

			# 	Relationship.find_or_create_by(account_id: account.id, sponsor_id: sponsor.id, yizkor_id: yizkor.id, 
			# 	                     kind: lp.relationship, source: lp.source) 
			# end
			# puts "people now has:" + Person.count.to_s + " records."
			# puts "relationships now has:" + Relationship.count.to_s + " records."
			# puts

					# TODO: make this more resilient -- what if no account found?  what if creating a mention fails?
					# TODO: DRY this code!
					# populate mentions
					# TODO: what if sponsor and yizkor have the same names?  how will find_or_create_by work?
					puts "Creating mentions.."
					LegacyMentions.all.each do |lmn|
						account = Account.find_by(tag: lmn.account_tag)
						case lmn.publication_type
						when "book"
							# TODO: looking up a person should not be "or_create_by", this is dangerous!
							# if person.nil? then
							# 	puts "#{lmn.account_tag} #{account.id} #{lmn.yizkor_first_name} #{lmn.yizkor_last_name}"
							# end
							person = Person.where("account_id = :acc_id AND 
							                      first_name = :f_name AND 
							                      last_name = :l_name AND 
							                      sort_order > 0",
							                      { acc_id: account.id, 
							                      	f_name: lmn.yizkor_first_name,
							                      	l_name: lmn.yizkor_last_name }).first
							Mention.find_or_create_by(mentionable_id: person.id, mentionable_type: "Person",
							                          year: lmn.publication_year, source: "migration") 

						when "holocaust"
							Mention.find_or_create_by(mentionable_id: account.id, mentionable_type: "Account",
							                          year: lmn.publication_year, source: "migration")
						end
					end
					puts "mentions now has:" + Mention.count.to_s + " records."
					puts

					# populate addresses
					# TODO: make this more resilient (what if account is not found?)
					# TODO: problem with zipcodes (or any other situation with zip not validating, for instance, should be handled)
					# TODO: specifically, "892	N01360	Mr. Jonathan Abels	45 Howland Road		W. Hartford	CT	06107	CHECK2	t" had a problem with zipcode being "06l07" as not valid
					# TODO: we currently have to rename 'deleted' to 'active' column name in the legacy_addresses table for this import to work
					# TODO: further, this process ignores addresses for which we have no matching accounts (ok for now)
			# puts "Creating addresses.."
			# LegacyAddresses.all.each do |ladd|
			# 	account = Account.find_by(tag: ladd.account_tag)
			# 	if account then
			# 		ladd.active ? del = nil : del = Time.now
			# 		# puts account.id, ladd.label, ladd.street1, ladd.street2, ladd.city, ladd.state, ladd.zip, ladd.source, del
			# 		Address.create!(account_id: account.id, label: ladd.label, 
			# 		                street1: ladd.street1, street2: ladd.street2, city: ladd.city,
			# 		                state: ladd.state, zip: ladd.zip, source: ladd.source,
			# 		                deleted_at: del)
			# 	end
			# end
			# puts "addresses now has:" + Address.count.to_s + " records."
			# puts

					# populate payments
					# TODO: make this more resilient (what if account is not found?)
			# puts "Creating payments.."
			# LegacyPayments.all.each do |lp|
			# 	account = Account.find_by(tag: lp.account_tag)
			# 	if account then
			# 		Payment.create!(account_id: account.id, amount: lp.amount, 
			# 		                paid_on: lp.paid_on, source: "migration")
			# 	end
			# end
			# puts "payments now has:" + Payment.count.to_s + " records."
			# puts

				else
					puts "Populating database with legacy data is CANCELLED.  No changes made."
				end

			rescue StandardError => e
				# log it
				puts e
			end

		end

end

