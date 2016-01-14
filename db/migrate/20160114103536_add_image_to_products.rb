class AddImageToProducts < ActiveRecord::Migration
  def change
  	change_column :products, :price, :decimal, default: 0.0
  	add_column :products, :image, :string
  end
end
