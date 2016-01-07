class CreateProductTypes < ActiveRecord::Migration
  def change
    create_table :product_types do |t|
      t.string :name
      t.integer :father_id

      t.timestamps null: false
    end
  end
end
