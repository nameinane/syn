class SetPaymentsToHandleOnlyTwoDecimalPlaces < ActiveRecord::Migration
  def change
  	change_column :payments, :amount, :decimal, precision: 8, scale: 2
  end
end
