# Create Aaron Fischman
Account.find_by(tag:"N09800").people.new(first_name:"Aaron", last_name:"Fischman", sort_order:0).save
# Make Aaron Fischman mention Todd Chernick in 2013
Person.find(2884).mention_yizkor(2715,2013,nil,true)

# Move Judy Kazis (yizkor) to the main Earle Kazis
Relationship.find_by(sponsor_id:1199).update_attributes(sponsor_id:1201)
Person.find(1199).destroy

# Move Steven Marcos (yizkor) to the main Belinda Roth
Relationship.find_by(sponsor_id:1538).update_attributes(sponsor_id:1540)
Person.find(1538).destroy

# Move Milton Walsey (yizkor) to the main Steven Walsey
