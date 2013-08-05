class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :person_id
      t.integer :yizkor_id
      t.string :kind
      t.string :source
      t.boolean :active

      t.timestamps
    end
  end
end
