class AddCreditToUserEventBalances < ActiveRecord::Migration
  def change

  	add_column :user_event_balances, :credit, :decimal

  end


end
