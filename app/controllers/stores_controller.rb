class StoresController < ApplicationController
    before_action :set_store, only: [:show, :edit, :update]
    before_action :check_login
    authorize_resource

    def index
        @active_stores = Store.alphabetical.active.paginate(page: params[:page]).per_page(10)
        @inactive_stores = Store.alphabetical.inactive.paginate(page: params[:page]).per_page(10)
    end

    def show
        current_assignments = @store.assignments.current
        @current_employees = current_assignments.map { |a| a.employee }
    end

    def edit
    end

    def new
        @store = Store.new
    end

    def create
        @store = Store.new(store_params)
        if @store.save
            redirect_to store_path(@store), notice: "#{@store.name} was added to the system."
        else
            render action: 'new'
        end
    end

    def update
        if @store.update(store_params)
            redirect_to store_path(@store), notice: "Updated store information for #{@store.name}."
        else
            render action: 'edit'
        end
    end

    # def destroy
    #     @store.destroy
    #     redirect_to stores_url
    # end

    private
    def store_params
        params.require(:store).permit(:name, :street, :city, :state, :zip, :phone, :active)
    end

    def set_store
        @store = Store.find(params[:id])
    end

end