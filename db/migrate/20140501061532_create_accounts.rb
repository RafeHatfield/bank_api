class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :card_number
      t.string :pin
      t.integer :balance

      t.timestamps
    end
  end
end
