class CreatePayGradeRates < ActiveRecord::Migration[7.0]
  def change
    create_table :pay_grade_rates do |t|
      t.references :pay_grade, null: false, foreign_key: true
      t.float :rate
      t.date :start_date
      t.date :end_date

      # t.timestamps
    end
  end
end
