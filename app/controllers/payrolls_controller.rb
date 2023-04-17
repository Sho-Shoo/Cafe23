class PayrollsController < ApplicationController
    before_action :check_login
    # authorize_resource

    def store_form
        authorize! :store_form, :payrolls_controller
    end

    def employee_form
        authorize! :employee_form, :payrolls_controller
    end

    def employee_payroll
        authorize! :employee_payroll, :payrolls_controller
        employee_id = params[:employee_id]
        @start_date = DateTime.parse(params[:start_date]).to_date
        @end_date = DateTime.parse(params[:end_date]).to_date
        employee = Employee.find(employee_id)
        date_range = DateRange.new(@start_date, @end_date)
        payroll_calculator = PayrollCalculator.new(date_range)
        @employee_payroll = payroll_calculator.create_payroll_record_for(employee)
    end

    def store_payroll
        authorize! :store_payroll, :payrolls_controller
        if current_user.role == 'manager'
            @store = current_user.current_assignment.store
        else
            @store = Store.find(params[:store_id])
        end

        @start_date = DateTime.parse(params[:start_date]).to_date
        @end_date = DateTime.parse(params[:end_date]).to_date
        date_range = DateRange.new(@start_date, @end_date)
        payroll_calculator = PayrollCalculator.new(date_range)
        @store_payroll = payroll_calculator.create_payrolls_for(@store)
    end

end