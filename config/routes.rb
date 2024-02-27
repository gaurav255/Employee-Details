Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'employee_details', to: 'employee_details#create'
  get 'tax_deduction', to: 'employee_details#tax_deduction'
end
