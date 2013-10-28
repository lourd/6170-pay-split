class RenameAmountInUserEventBalancesToDebt < ActiveRecord::Migration
  def change
  	rename_column :user_event_balances, :amount, :debt

  end
end
