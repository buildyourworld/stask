class CreateInformation < ActiveRecord::Migration
  def change
    create_table :information do |t|
      	t.string :url
      	t.belongs_to :recipe, index: true

		t.timestamps null: false
    end
    add_foreign_key :information, :recipes
  end
end
