class AddEventIdToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :event_id, :integer
  end
end
