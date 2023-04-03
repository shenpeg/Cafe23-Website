Rails.application.routes.draw do
  
  # Semi-static page routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy
  get 'home/search', to: 'home#search', as: :search

  # Authentication routes
  resources :sessions
  resources :users
  get 'employees/new', to: 'employees#new', as: :signup
  get 'employees/edit', to: 'employees#edit', as: :edit_current_user
  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout

  # Resource routes (maps HTTP verbs to controller actions automatically):
  resources :stores, except: [:destroy]
  resources :employees
  resources :assignments
  resources :shifts
  resources :shift_jobs, only: [:destroy]
  resources :jobs, except: [:show]
  resources :pay_grades, except: [:destroy]
  resources :pay_grade_rates

  # Custom routes
  #get 'shift_today', to: 'shifts#route_clock', as: :shift_today_path
  get 'shift_jobs/new', to: 'shift_jobs#new', as: :new_shift_job
  post 'shift_jobs', to: 'shift_jobs#create', as: :shift_jobs

  get 'payrolls/store_form', to: 'payrolls#store_form', as: :store_form
  get 'payrolls/employee_form', to: 'payrolls#employee_form', as: :employee_form

  # You can have the root of your site routed with 'root'
  root 'home#index'
  
end
