class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.decimal :total_balance
      t.integer :organizer

      t.timestamps
    end
  end
end
