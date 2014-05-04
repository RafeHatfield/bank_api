class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :account, index: true
      t.string :event
      t.integer :amount

      t.timestamps
    end
  end
end
