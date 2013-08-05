class RemoveActiveFromRelationships < ActiveRecord::Migration
  def change
  	remove_column :relationships, :active
  end
end
