Rails.application.routes.draw do
  # API routing
  scope module: 'api', defaults: {format: 'json'} do
    namespace :v1 do
      # provide the routes for the API here

      
      

    end
  end

  # Semi-static page routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy
  get 'home/search', to: 'home#search', as: :search

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
  resources :assignments
  resources :jobs, except: [:show]

  # You can have the root of your site routed with 'root'
  root 'home#index'
  
end
