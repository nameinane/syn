class RemoveActiveFromPeople < ActiveRecord::Migration
  def change
  	remove_column :people, :active
  end
end
