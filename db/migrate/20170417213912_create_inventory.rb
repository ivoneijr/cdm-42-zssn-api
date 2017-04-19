class CreateInventory < ActiveRecord::Migration[5.0]
  
  def change
    create_table :inventories do |t|
      t.integer :quantity
      t.belongs_to :item, null: true, index: true
      t.belongs_to :survivor, null: true, index: true
      t.timestamps
    end
  end
end
