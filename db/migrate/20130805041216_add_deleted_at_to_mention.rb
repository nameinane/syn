class AddDeletedAtToMention < ActiveRecord::Migration
  def change
    add_column :mentions, :deleted_at, :datetime
  end
end
