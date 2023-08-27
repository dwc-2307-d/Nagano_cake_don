class CreateItems < ActiveRecord::Migration[6.1]
  def change
      create_table :items do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.boolean :is_status
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
