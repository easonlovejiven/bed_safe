class AddImageToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :image, :string
  	add_column :products, :describtion, :text
  	change_column :products, :price, :decimal, default: 0.0
  	change_column :products, :discount, :boolean, default: true
  	change_column :products, :top_and_down, :boolean, default: true
  end
end
