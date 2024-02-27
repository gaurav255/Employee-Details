class CreateEmployeeDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :employee_details do |t|
      t.integer :employee_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :phone_numbers, default: [], array: true
      t.datetime :date_of_joining
      t.decimal :salary

      t.timestamps
    end
  end
end
