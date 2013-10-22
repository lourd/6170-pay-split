class CreatePaymentSplits < ActiveRecord::Migration
  def change
    create_table :payment_splits do |t|
      t.decimal :amount
      t.integer :receiver

      t.timestamps
    end
  end
end
