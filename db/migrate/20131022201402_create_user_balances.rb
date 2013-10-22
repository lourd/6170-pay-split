class CreateUserBalances < ActiveRecord::Migration
  def change
    create_table :user_balances do |t|
      t.decimal :amount

      t.timestamps
    end
  end
end
