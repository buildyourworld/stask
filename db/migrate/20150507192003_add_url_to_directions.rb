class AddUrlToDirections < ActiveRecord::Migration
  def change
    add_column :directions, :url, :string
  end
end
