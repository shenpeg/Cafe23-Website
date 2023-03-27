class CreateAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :assignments do |t|
      t.references :store, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true
      t.references :pay_grade, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date

      # t.timestamps
    end
  end
end
