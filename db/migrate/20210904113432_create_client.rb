class CreateClient < ActiveRecord::Migration[6.1]
  def change
  	 create_table :clients do |t|
      t.string :last_name
      t.string :first_name
      t.string :surname
      t.string :uid
      t.string :tag
      t.timestamps
    end
  end
end
