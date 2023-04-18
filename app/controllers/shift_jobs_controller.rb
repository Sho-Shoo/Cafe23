class ShiftJobsController < ApplicationController
    before_action :set_shift_job, only: [:destroy]
    before_action :check_login
    authorize_resource

    def new
        if params[:shift_id]
            @shift_id = params[:shift_id]
        else
            @shift_id = nil
        end
        @shift_job = ShiftJob.new
    end

    def create
        @shift_job = ShiftJob.new(shift_job_params)
        if @shift_job.save
            redirect_to shift_path(@shift_job.shift), notice: "Successfully added a shift_job."
        else
            render action: 'new'
        end
    end

    def destroy
        @shift_job.destroy
        redirect_to shift_path(@shift_job.shift)
    end


    private
    def shift_job_params
        params.require(:shift_job).permit(:job_id, :shift_id)
    end

    def set_shift_job
        @shift_job = ShiftJob.find(params[:id])
    end
end
