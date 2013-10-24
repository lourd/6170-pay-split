class AddUserIdToPaymentSplits < ActiveRecord::Migration
  def change
    add_column :payment_splits, :user_id, :integer
  end
end
