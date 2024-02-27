class EmployeeDetailsController < ApplicationController

    def create
        @employee_details = EmployeeDetail.new(employee_params)
        if @employee_details.save
            render json: {message: "Employee Details stored successfully!!", employee_details: @employee_details}, status: :created
        else
            render json: {errors: @employee_details.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def tax_deduction
        employees = EmployeeDetail.where('extract(year from date_of_joining) = ?', Date.today.year)
    
        result = employees.map do |employee|
          {
            employee_code: employee.employee_id,
            first_name: employee.first_name,
            last_name: employee.last_name,
            yearly_salary: calculate_salary(employee),
            tax_amount: calculate_tax(employee),
            cess_amount: calculate_cess(employee)
          }
        end
    
        render json: {yearly_data: result}, status: :ok
    end

    private

    def employee_params
        params.require(:employee_details).permit(:employee_id, :first_name, :last_name, :email, :date_of_joining, :salary, phone_numbers: [])
    end

    def calculate_salary(employee)
        months_worked = (Date.today - employee.date_of_joining.to_date).to_i / 30
        total_salary = employee.salary * months_worked
        total_salary
    end
    
    def calculate_tax(employee)
        yearly_salary = calculate_salary(employee)
    
        if yearly_salary <= 250000
          0
        elsif yearly_salary <= 500000
          (yearly_salary - 250000) * 0.05
        elsif yearly_salary <= 1000000
          250000 * 0.05 + (yearly_salary - 500000) * 0.1
        else
          250000 * 0.05 + 500000 * 0.1 + (yearly_salary - 1000000) * 0.2
        end
    end
    
    def calculate_cess(employee)
        yearly_salary = calculate_salary(employee)
        cess_rate = yearly_salary > 2500000 ? 0.02 : 0
        yearly_salary * cess_rate
    end
end
