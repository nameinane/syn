class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :account_id
      t.string :label
      t.string :street1
      t.string :street2
      t.string :city
      t.string :state
      t.string :zip
      t.string :source
      t.boolean :active

      t.timestamps
    end
  end
end
