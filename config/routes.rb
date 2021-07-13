Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root
  root 'articles#index'

  # Users routes
  get 'signup'  => 'users#new'
  resources :users
  # Articles routes
  resources :articles do 
    resources :comments
  end

  # Comments routes
end
