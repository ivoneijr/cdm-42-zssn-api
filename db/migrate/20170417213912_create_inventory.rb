class CreateInventory < ActiveRecord::Migration[5.0]
  
  def change
    create_table :inventories do |t|
      t.integer :quantity
      t.references :item, null: true, index: true
      t.references :survivor, null: true, index: true
      t.timestamps
    end
  end
end
