Rails.application.routes.draw do
  # root
  root 'articles#index'
  # Filter latest articles
  get 'articles/popular' => 'articles#popular'

  # Static pages
  get 'static_pages/help' => 'static_pages#help'
  get 'static_pages/contact' => 'static_pages#contact'
  get 'static_pages/about' => 'static_pages#about'

  # Session tracking routes
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  # Users routes
  get 'signup'     => 'users#new'

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

end
