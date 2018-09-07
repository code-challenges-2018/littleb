class CreateInventions < ActiveRecord::Migration[5.2]
  def change
    create_table :inventions do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end

    create_table :bits_inventions, id: false do |t|
      t.integer :bit_id
      t.integer :invention_id
    end

    create_table :inventions_materials, id: false do |t|
      t.integer :invention_id
      t.integer :material_id
    end
  end
end
