class ShiftsController < ApplicationController
    before_action :set_shift, only: [:show, :edit, :update, :destroy]
    before_action :check_login
    authorize_resource

    def index
        @shifts = Shift.upcoming.chronological
    end

    def show
    end

    def new
        @shift = Shift.new
    end

    def create
        @shift = Shift.new(shift_params)
        if @shift.save
            redirect_to shift_path(@shift), notice: "Successfully added a shift."
        else
            render action: 'new'
        end
    end

    def destroy
        if @shift.destroy
            redirect_to shifts_url
        else
            render action: 'show'
        end
    end

    def update
        if @shift.update(shift_params)
            redirect_to shift_path(@shift), notice: "Updated a shift's information."
        else
            render action: 'edit'
        end
    end

    private
    def shift_params
        params.require(:shift).permit(:assignment_id, :date, :start_time, :end_time, :notes, :status)
    end

    def set_shift
        @shift = Shift.find(params[:id])
    end
end