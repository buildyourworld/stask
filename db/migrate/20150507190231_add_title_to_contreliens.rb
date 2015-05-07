class AddTitleToContreliens < ActiveRecord::Migration
  def change
    add_column :contreliens, :title, :string
  end
end
