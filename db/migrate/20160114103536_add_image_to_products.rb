class AddImageToProducts < ActiveRecord::Migration
	def up
		add_column :products, :user_id, :integer
		add_column :products, :image, :string
  	change_column :products, :discount, :boolean, default: true
  	change_column :products, :top_and_down, :boolean, default: true
	end

	def down
		change_column :products, :price, :decimal, default: 0.0
	end

end
