class AddTitleToInformation < ActiveRecord::Migration
  def change
    add_column :information, :title, :string
  end
end
