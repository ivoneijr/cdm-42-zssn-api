class InfectionReports < ActiveRecord::Migration[5.0]
  def change
    create_table :infection_reports do |t|
      t.timestamps
    end
    
    add_reference :infection_reports, :reporter, null: true, index: true
    add_reference :infection_reports, :infected, null: true, index: true
  end
end
