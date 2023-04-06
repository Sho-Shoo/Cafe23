class JobsController < ApplicationController
    before_action :set_job, only: [:show, :edit, :update, :destroy]
    before_action :check_login
    authorize_resource

    def index
        @active_jobs = Job.active.alphabetical
    end

    def edit
    end

    def new
        @job = Job.new
    end

    def create
        @job = Job.new(job_params)
        if @job.save
            redirect_to jobs_path, notice: "Successfully added a job (#{@job.name})."
        else
            render action: 'new'
        end
    end

    def update
        if @job.update(job_params)
            redirect_to jobs_path, notice: "Updated information of job #{@job.name}."
        else
            render action: 'edit'
        end
    end

    def destroy
        if @job.destroy
            redirect_to jobs_url
        else
            render action: 'index'
        end


    end

    private
    def job_params
        params.require(:job).permit(:name, :description, :active)
    end

    def set_job
        @job = Job.find(params[:id])
    end


end