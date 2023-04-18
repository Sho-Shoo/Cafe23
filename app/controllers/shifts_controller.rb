class ShiftsController < ApplicationController
    before_action :set_shift, only: [:show, :edit, :update, :destroy]
    before_action :set_upcoming_shifts, only: [:time_clock, :time_in, :time_out]
    before_action :check_login
    authorize_resource

    def index
        @upcoming_shifts = Shift.upcoming.chronological.paginate(page: params[:page]).per_page(10)
        @completed_shifts = Shift.completed.chronological.paginate(page: params[:page]).per_page(10)
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

    def time_clock
        if @shift_today.nil?
            redirect_to home_path, notice: "You do not have any shifts today"
        end
    end

    def time_in
        if @shift_today.nil?
            redirect_to home_path, notice: "You do not have any shifts today"
        else # do have shift today, then time-in
            time_clock = TimeClock.new(@shift_today)
            time_clock.start_shift_at
            redirect_to home_path, notice: "Your shift has started."
        end
    end

    def time_out
        if @shift_today.nil?
            redirect_to home_path, notice: "You do not have any shifts today"
        else # do have shift today, then time-in
            time_clock = TimeClock.new(@shift_today)
            time_clock.end_shift_at
            redirect_to home_path, notice: "Your shift has ended."
        end
    end

    private
    def shift_params
        params.require(:shift).permit(:assignment_id, :date, :start_time, :end_time, :notes, :status)
    end

    def set_shift
        @shift = Shift.find(params[:id])
    end

    def set_upcoming_shifts
        today_date_range = DateRange.new(Date.current, Date.current)
        @shift_today = Shift.for_employee(current_user).for_dates(today_date_range).first
        @upcoming_shifts = Shift.for_employee(current_user).upcoming.chronological.paginate(page: params[:page]).per_page(10)
    end
end