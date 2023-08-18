class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|

      t.timestamps
      t.references :customer, foreign_key: true, null: false
      t.string :address, null: false
      t.string :post_code, null: false
      t.string :name, null: false
      
    end
  end
end
