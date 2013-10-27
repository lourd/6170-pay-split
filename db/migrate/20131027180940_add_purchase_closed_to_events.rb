class AddPurchaseClosedToEvents < ActiveRecord::Migration
  def change
    add_column :events, :purchase_closed, :boolean
  end
end
