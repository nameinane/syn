class AddDeletedAtToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :deleted_at, :datetime
  end
end
