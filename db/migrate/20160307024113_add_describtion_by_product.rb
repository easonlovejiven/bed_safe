class AddDescribtionByProduct < ActiveRecord::Migration
  def change
  	add_column :products, :describtion, :text
  end
end
