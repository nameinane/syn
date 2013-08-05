class AddDeletedAtToRelationship < ActiveRecord::Migration
  def change
    add_column :relationships, :deleted_at, :datetime
  end
end
