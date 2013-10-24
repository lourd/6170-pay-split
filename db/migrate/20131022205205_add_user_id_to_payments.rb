class AddUserIdToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :user_id, :integer
  end
end
