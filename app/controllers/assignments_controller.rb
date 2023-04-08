class AssignmentsController < ApplicationController
    before_action :set_assignment, only: [:show, :edit, :update, :destroy]
    before_action :check_login
    authorize_resource

    def index
        if current_user.role == 'employee'
            user_assignments = Assignment.for_employee(current_user)
            @current_assignments = user_assignments.current.by_employee.paginate(page: params[:page]).per_page(10)
            @past_assignments = user_assignments.past.by_employee.paginate(page: params[:page]).per_page(10)
        else
            @current_assignments = Assignment.current.by_employee.paginate(page: params[:page]).per_page(10)
            @past_assignments = Assignment.past.by_employee.paginate(page: params[:page]).per_page(10)
        end
    end


    def show
    end

    def edit
    end

    def new
        @assignment = Assignment.new
    end

    def create
        @assignment = Assignment.new(assignment_params)
        if @assignment.save
            redirect_to assignments_path, notice: "Successfully added the assignment."
        else
            render action: 'new'
        end
    end

    def update
        if @assignment.update(assignment_params)
            redirect_to assignments_path, notice: "Updated assignment information."
        else
            render action: 'edit'
        end
    end

    def destroy
        if @assignment.destroy
            redirect_to assignments_url, notice: "Removed assignment from the system."
        else
            render action: 'show'
        end
    end

    private
    def assignment_params
        params.require(:assignment).permit(:store_id, :employee_id, :pay_grade_id, :start_date, :end_date)
    end

    def set_assignment
        @assignment = Assignment.find(params[:id])
    end

end