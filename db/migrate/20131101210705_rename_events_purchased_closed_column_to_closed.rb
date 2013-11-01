class RenameEventsPurchasedClosedColumnToClosed < ActiveRecord::Migration
  def change
  	rename_column :events, :purchase_closed, :closed
  end
end
