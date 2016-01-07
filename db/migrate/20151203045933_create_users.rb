class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :realname
      t.integer :gender
      t.integer :age
      t.integer :province
      t.integer :city

      t.timestamps null: false
    end
  end
end
