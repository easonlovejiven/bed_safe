class AddUniqueIndexTradingAccountIdExecIdToExecDetail < ActiveRecord::Migration
  def up
    remove_index(:exec_details, [:trading_account_id, :exec_id]) if index_exists?(:exec_details, [:trading_account_id, :exec_id])
    add_index :exec_details, [:trading_account_id, :exec_id], unique: true
  end

  def down
    remove_index(:exec_details, [:trading_account_id, :exec_id]) if index_exists?(:exec_details, [:trading_account_id, :exec_id], unique: true)
    add_index :exec_details, [:trading_account_id, :exec_id]
  end
end
