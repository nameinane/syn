class AddDeletedAtToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :deleted_at, :datetime
  end
end
