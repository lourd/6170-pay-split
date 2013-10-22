class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.decimal :amount
      t.text :description

      t.timestamps
    end
  end
end
