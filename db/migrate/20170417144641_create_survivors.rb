class CreateSurvivors < ActiveRecord::Migration[5.0]
  def change
    create_table :survivors do |t|
      t.string :name
      t.integer :age
      t.string :gender, limit: 1
      t.string :last_latitude
      t.string :last_longitude
      t.boolean :infected, default: false

      t.timestamps
    end
  end
end
