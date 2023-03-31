Rails.application.routes.draw do
  # API routing
  scope module: 'api', defaults: {format: 'json'} do
    namespace :v1 do
      # provide the routes for the API here

      
      

    end
  end

  # Semi-static page routes
  get 'home', to: 'home#index', as: :home

  # Authentication routes
  resources :sessions
  resources :employees
  get 'employees/new', to: 'employees#new', as: :signup
  get 'employee/edit', to: 'employees#edit', as: :edit_current_employee
  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout

  # Resource routes (maps HTTP verbs to controller actions automatically):
  # Routes for regular HTML views go here...
  resources :stores, except: [:destroy]
  resources :employees

  # You can have the root of your site routed with 'root'
  root 'home#index'
  
end
