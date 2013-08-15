class AddAccountToRelationships < ActiveRecord::Migration
  def change
  	add_column :relationships, :account_id, :integer
  end
end
