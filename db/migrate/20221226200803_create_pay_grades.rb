class CreatePayGrades < ActiveRecord::Migration[7.0]
  def change
    create_table :pay_grades do |t|
      t.string :level
      t.boolean :active, default: true

      # t.timestamps
    end
  end
end
