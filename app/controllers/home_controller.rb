class HomeController < ApplicationController
    def index
        # redirect to time_clock only if current_user is a employee and has shift today
        if not current_user.nil? and current_user.role == 'employee'
            today_date_range = DateRange.new(Date.current, Date.current)
            shift_today = Shift.for_employee(current_user).for_dates(today_date_range).first
            if shift_today
                redirect_to time_clock_path
            else
                flash[:notice] = "You do not have any shifts today"
            end
        end
    end

    def about
    end

    def contact
    end

    def privacy
    end

    def search
        # redirect_back(fallback_location: home_path) if params[:query].blank?
        # @query = params[:query]
        # @owners = Owner.search(@query)
        # @pets = Pet.search(@query)
        # @total_hits = @owners.size + @pets.size
    end
end