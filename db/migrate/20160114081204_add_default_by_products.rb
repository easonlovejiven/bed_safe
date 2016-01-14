class AddDefaultByProducts < ActiveRecord::Migration
  def change
	  change_column :products, :discount, :integer, default: 1
	  change_column :products, :top_and_down, :integer, default: 1
	end
end
