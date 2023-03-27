class CreateShifts < ActiveRecord::Migration[7.0]
  def change
    create_table :shifts do |t|
      t.references :assignment, null: false, foreign_key: true
      t.date :date
      t.time :start_time
      t.time :end_time
      t.text :notes
      t.integer :status

      # t.timestamps
    end
  end
end
