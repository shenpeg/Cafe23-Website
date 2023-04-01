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
  resources :stores
  resources :employees
  resources :assignments
  resources :jobs
  resources :paygrades
  resources :shifts



  # You can have the root of your site routed with 'root'
  root 'home#index'
  
end
