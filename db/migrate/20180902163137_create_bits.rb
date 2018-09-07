class CreateBits < ActiveRecord::Migration[5.2]
  def change
    create_table :bits do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
