Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root
  root 'articles#index'

  # Users routes
  get 'signup'     => 'users#new'
  # resources :users

  resources :users do
    resources :articles, only: [:edit, :create, :destroy] do
      collection do
        delete :destroy_all
      end
    end
  end
  
  # Articles & Comments routes
  resources :articles do 
    resources :comments, only: [:edit, :create, :destroy] do
      collection do
        delete :destroy_all
      end
    end
  end

  patch '/articles/:article_id/comments/:id' => 'comments#update'

  # Session tracking routes
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'


end
