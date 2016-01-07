class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :type
      t.integer :price
      t.integer :discount
      t.integer :top_and_down
      t.date :product_date

      t.timestamps null: false
    end
  end
end
