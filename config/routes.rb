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
  end
  resources :uploaders, only: [:create]
end
