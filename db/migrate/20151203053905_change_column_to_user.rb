class ChangeColumnToUser < ActiveRecord::Migration
  def change
  	 remove_column :users, :age, :integer
  	 add_column :users, :birthday, :date
  end
end
