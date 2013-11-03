class AddPaymentReceivedToUserEventBalances < ActiveRecord::Migration
  def change
  	add_column :user_event_balances, :payment_received, :decimal
  end
end
