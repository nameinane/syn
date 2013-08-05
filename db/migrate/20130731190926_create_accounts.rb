class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :tag
      t.string :name
      t.boolean :active

      t.timestamps
    end
  end
end
