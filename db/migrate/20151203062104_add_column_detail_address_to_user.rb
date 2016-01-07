class AddColumnDetailAddressToUser < ActiveRecord::Migration
  def change
  	add_column :users, :detail_address, :text
  end
end
