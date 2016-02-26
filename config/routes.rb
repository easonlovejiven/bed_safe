Rails.application.routes.draw do
  root 'welcome#index'
  get 'signup' => 'users#signup'
  get 'signin' => 'users#signin'
  post 'login_session' => 'users#login_session'
  delete 'logout' => 'users#logout'
  resources :users, only: [:create]
  resource :ajax, controller: :ajax, only: [] do
    get :fetch_cities
  end
  resources :products do
    member do
      post :change_top_and_down
      post :change_discount
    end

    collection do
      post :ajax_del_product
      get :search_user
      post :fetch_products
    end
  end
  resources :uploaders, only: [:create]
  get 'pages/:type/:id' => "pages#show"
end
