class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
			t.references :mentionable, polymorphic: true
      t.integer :year

      t.timestamps
    end
  end
end
