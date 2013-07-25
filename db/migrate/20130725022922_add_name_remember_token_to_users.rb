class AddNameRememberTokenToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :name, :string
  	add_column :users, :remember_token, :string
  	add_index :users, :remember_token
  end
end
