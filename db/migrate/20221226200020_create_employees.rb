class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :ssn
      t.date :date_of_birth
      t.string :phone
      t.integer :role
      t.boolean :active, default: true
      t.string :username
      t.string :password_digest

      # t.timestamps
    end
  end
end
