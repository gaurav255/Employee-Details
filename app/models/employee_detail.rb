class EmployeeDetail < ApplicationRecord
    validates :first_name, :last_name, :email, :salary, :date_of_joining, :phone_numbers, presence: true
    validates :employee_id, :email, uniqueness: true
    
    validate :set_employee_id

    def set_employee_id
        return if employee_id.present?
        maximum = EmployeeDetail.maximum(:employee_id)
        self.employee_id = maximum ? (maximum + 1) : 1
    end
end
