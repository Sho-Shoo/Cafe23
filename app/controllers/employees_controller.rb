class EmployeesController < ApplicationController
    before_action :set_employee, only: [:show, :edit, :update, :destroy]
    before_action :check_login
    authorize_resource

    def index
        if current_user.role == 'manager'
            subordinates = current_user.current_assignment.store.employees
            @active_employees = subordinates.active
            @inactive_employees = subordinates.inactive
        else
            @active_employees = Employee.alphabetical.active.paginate(page: params[:page]).per_page(10)
            @inactive_employees = Employee.alphabetical.inactive.paginate(page: params[:page]).per_page(10)
        end
    end

    def show
        all_assignments = @employee.assignments
        @current_assignment = all_assignments.current
        @other_assignments = all_assignments.map{ |a| a if a !=@current_assignment }
    end

    def edit
    end

    def new
        @employee = Employee.new
    end

    def create
        @employee = Employee.new(employee_params)
        if @employee.save
            redirect_to employee_path(@employee), notice: "Successfully added #{@employee.proper_name} as an employee."
        else
            render action: 'new'
        end
    end

    def update
        if @employee.update(employee_params)
            redirect_to employee_path(@employee), notice: "Updated #{@employee.proper_name}'s information."
        else
            render action: 'edit'
        end
    end

    def destroy
        if @employee.destroy
            redirect_to employees_url
        else
            render action: 'show'
        end


    end

    private
    def employee_params
        params.require(:employee).permit(:first_name, :last_name, :ssn, :date_of_birth, :phone, :role, :username,
                                         :password, :password_confirmation, :active)
    end

    def set_employee
        @employee = Employee.find(params[:id])
    end


end