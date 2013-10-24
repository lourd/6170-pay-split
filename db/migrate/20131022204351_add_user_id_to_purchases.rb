class AddUserIdToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :user_id, :integer
  end
end
