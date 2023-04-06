class PayGradeRatesController < ApplicationController
    # before_action :set_pay_grade_rate, only: [:show, :edit, :update, :destroy]
    before_action :check_login
    authorize_resource

    def new
        @pay_grade_rate = PayGradeRate.new
    end

    def create
        @pay_grade_rate = PayGradeRate.new(pay_grade_rate_params)
        if @pay_grade_rate.save
            redirect_to pay_grade_path(@pay_grade_rate.pay_grade), notice: "Successfully added a pay grade rate."
        else
            render action: 'new'
        end
    end


    private
    def pay_grade_rate_params
        params.require(:pay_grade_rate).permit(:pay_grade_id, :rate, :start_date, :end_date)
    end
end