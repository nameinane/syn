class RemoveActiveFromAccount < ActiveRecord::Migration
  def change
  	remove_column :accounts, :active
  end
end
