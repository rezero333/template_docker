class CreateAccount < ActiveRecord::Migration[6.1]
  def change
  	 create_table :accounts do |t|
  	  t.integer :client_id
      t.string :uid
      t.integer :currency
      t.timestamps
    end
  end
end
