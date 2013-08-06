class RemoveActiveFromAddress < ActiveRecord::Migration
  def change
  	remove_column :addresses, :active
  end
end
