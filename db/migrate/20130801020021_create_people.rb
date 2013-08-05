class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.integer :account_id
      t.string :first_name
      t.string :last_name
      t.integer :sort_order
      t.string :source
      t.boolean :active

      t.timestamps
    end
  end
end
