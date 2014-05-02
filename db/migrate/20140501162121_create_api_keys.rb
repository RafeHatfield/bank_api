class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.references :account, index: true
      t.string :token

      t.timestamps
    end
  end
end
