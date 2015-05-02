class CreateContreliens < ActiveRecord::Migration
  def change
    create_table :contreliens do |t|

    t.string :url
    t.integer :contrelien_poly_id
    t.string :contrelien_poly_type

    t.timestamps null: false
    end
  end
end
