class MakeNewAccountsActiveByDefault < ActiveRecord::Migration
  def change
  	change_column :accounts, :active, :boolean, default: 'true'
  end
end
