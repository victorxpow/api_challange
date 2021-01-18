class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.integer :balance
      t.integer :account_number
      t.text :token

      t.timestamps
    end
  end
end
