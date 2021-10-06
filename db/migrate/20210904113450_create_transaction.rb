class CreateTransaction < ActiveRecord::Migration[6.1]
  def change
  	 create_table :transactions do |t|
  	  t.integer :client_id
      t.integer :account_id
      t.decimal :amount
      t.integer :transaction_type
      t.timestamps
    end
  end
end
