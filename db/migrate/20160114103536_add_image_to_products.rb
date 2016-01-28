class AddImageToProducts < ActiveRecord::Migration
	def up
		add_column :products, :user_id, :integer
		add_column :products, :image, :string
  	add_column :products, :describtion, :text
  	change_column :products, :discount, :boolean, default: true
  	change_column :products, :top_and_down, :boolean, default: true
	end

	def change
		change_column :products, :price, :decimal, default: 0.0
		add_column :products, :views_count, :integer
	end

end
