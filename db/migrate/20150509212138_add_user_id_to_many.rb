class AddUserIdToMany < ActiveRecord::Migration
  def change
  	add_column :directions, :user_id, :integer
  	add_column :information, :user_id, :integer
  	add_column :contreliens, :user_id, :integer  	
  end
end
