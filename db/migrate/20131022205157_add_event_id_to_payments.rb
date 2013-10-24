class AddEventIdToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :event_id, :integer
  end
end
