Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  # root
  root 'articles#index'
  # Filter latest articles
  get 'articles/popular' => 'articles#popular'

  # Static pages
  get '/help' => 'static_pages#help'
  get '/contact' => 'static_pages#contact'
  get '/about' => 'static_pages#about'
  get '/privacy_policy' => 'static_pages#privacy_policy'
  get '/terms_and_conditions' => 'static_pages#terms_and_conditions'
  get '/disclaimer' => 'static_pages#disclaimer'

  # Session tracking routes
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  # Users routes
  get 'signup'     => 'users#new'

  resources :users do
    get    '/profile'   => 'users#show_user_articles'
    get    '/favorites' => 'users#favorites'
    post   '/delete_profile_image'   => 'users#delete_profile_image', as: :delete_profile_image
    resources :articles, only: [:edit, :create, :destroy] do
      collection do
        delete :destroy_all
      end
    end
  end
  
  # Articles & Comments routes
  resources :articles do 
    post '/favorites' => 'users#add_favorite'
    delete  '/favorites' => 'users#remove_favorite'
    resources :comments, only: [:edit, :create, :destroy] do
      collection do
        delete :destroy_all
      end
      resources :comment_likes
    end
    resources :likes
  end

  patch '/articles/:article_id/comments/:id' => 'comments#update'

  resources :account_activations, only: [:edit]
  
end
